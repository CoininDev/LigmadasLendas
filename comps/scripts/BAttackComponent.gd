extends Node3D
class_name BAttackComponent
@export var atk_damage: float
@export var atk_cooldown: float
@export var range: float
@export var nav_comp: NavigationComponent
@export var hero:HeroBase
var cancelling_actions = ["mright"]
var target: Node3D
var blocked:bool = false
@onready var range_show = $range_show
@onready var timer = $Timer

signal attacked

func _ready():
	var escala = 0.4
	range_show.scale.x = range * escala
	range_show.scale.z = range * escala
	timer.timeout.connect(timeout)
	timer.wait_time = atk_cooldown
	if hero.has_method("batk_attacked"):
		attacked.connect(hero.batk_attacked)

func _process(delta):
	if target:
		if target.is_in_group("hitbox_owner"):
			var distance = target.global_position.distance_to(global_position)
			if distance > range:
				walk()
			else:
				if timer.is_stopped():
					#attack()
					timer.start()
	else:
		timer.stop()
func _input(event):
	for cancelling_action in cancelling_actions:
		if Input.is_action_just_pressed(cancelling_action) or Input.is_action_just_released(cancelling_action):
			cancel()

func walk():
	nav_comp.select_destiny(target.position, range-0.2)

func attack():
	var atk = Attack.new()
	atk.physic_damage = atk_damage
	atk.caster = hero
	attacked.emit(target)
	target.dmgr.damage(atk)

func timeout():
	timer.wait_time = atk_cooldown
	var distance = target.global_position.distance_to(global_position)
	if distance <= range:
		attack()
	



func cancel():
	target = null

func select_target(x:Node3D):
	if !blocked:
		target = x
