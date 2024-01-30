extends Node3D
class_name BAttackComponent
@export var atk_damage: float
@export var atk_cooldown: float
@export var range: float
@export var nav_comp: NavigationComponent
var cancelling_actions = ["mright"]
var target: Node3D
var blocked:bool = false
@onready var range_show = $range_show
@onready var timer = $Timer

func _ready():
	var escala = 0.4
	range_show.scale.x = range * escala
	range_show.scale.z = range * escala
	timer.timeout.connect(timeout)
	timer.wait_time = atk_cooldown

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
	show_range_handler()
	for cancelling_action in cancelling_actions:
		if Input.is_action_just_pressed(cancelling_action) or Input.is_action_just_released(cancelling_action):
			cancel()

func walk():
	nav_comp.select_destiny(target.position, range-0.2)

func attack():
	var atk = Attack.new()
	atk.physic_damage = atk_damage
	atk.caster = self
	target.damage(atk)

func timeout():
	timer.wait_time = atk_cooldown
	var distance = target.global_position.distance_to(global_position)
	if distance <= range:
		attack()
	

func show_range_handler():
	if Input.is_action_just_pressed("show_range"):
		range_show.visible = true
	if Input.is_action_just_released("show_range"):
		range_show.visible = false

func cancel():
	target = null

func select_target(x:Node3D):
	if !blocked:
		target = x
