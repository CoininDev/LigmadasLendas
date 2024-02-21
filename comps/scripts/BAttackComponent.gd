extends Node3D
class_name BAttackComponent

## PARAMETERS
@export var atk_damage: float
@export var atk_cooldown: float
@export var range: float
@export var nav_comp: NavigationComponent
@export var hero:Node3D

## VARIABLES
var cancelling_actions = ["mright"]
var target: Node3D
var blocked:bool = false
var in_range_bodies:Array

## OBJECTS
@onready var range_show:Sprite3D = $range_show
@onready var timer:Timer = $Timer
@onready var area:Area3D = $Area3D
@onready var area_col:CollisionShape3D = $Area3D/CollisionShape3D
signal attacked


func _ready():
	var escala = 0.6
	if range_show: range_show.scale.x = range * escala
	if range_show: range_show.scale.z = range * escala
	area_col.shape.radius = range 
	timer.timeout.connect(timeout)
	timer.wait_time = atk_cooldown
	if hero.has_method("batk_attacked"):
		attacked.connect(hero.batk_attacked)

func _process(delta):
	if is_instance_valid(target):
		in_range_bodies = area.get_overlapping_bodies().slice(1)
		if !in_range_bodies.has(target):
			walk()
		else:
			if timer.is_stopped():
				attack()
				timer.start()
	else:
		timer.stop()
	#in_range_bodies = area.get_overlapping_bodies().slice(1)
	#if target:
		#walk()
func _input(event):
	for cancelling_action in cancelling_actions:
		if Input.is_action_just_pressed(cancelling_action) or Input.is_action_just_released(cancelling_action):
			cancel()

func walk():
	nav_comp.select_destiny_path(target.position, range-0.2)
	if in_range_bodies.has(target) and timer.is_stopped():
		timer.start()

func attack():
	var atk = Attack.new()
	atk.physic_damage = atk_damage
	atk.caster = hero
	attacked.emit(target)
	target.dmgr.damage(atk)

func timeout():
	timer.wait_time = atk_cooldown
	if target:
		#var distance = target.global_position.distance_to(global_position)
		if in_range_bodies.has(target):
			attack()

func cancel():
	target = null

func select_target(x:Node3D):
	if !blocked:
		target = x
