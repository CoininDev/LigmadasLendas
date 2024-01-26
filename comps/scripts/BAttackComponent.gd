extends Node3D
class_name BAttackComponent
@export var atk_damage: float
@export var atk_cooldown: float
@export var action = "mleft"
@export var range: float
@export var nav_comp: NavigationComponent
var cancelling_actions = ["mright"]
var target: Node3D
@onready var range_show = $range_show
@onready var timer = $Timer

func _ready():
	var escala = 0.4
	range_show.scale.x = range * escala
	range_show.scale.z = range * escala
	timer.timeout.connect(timeout)

func _process(delta):
	if target:
		if target.is_in_group("hitbox_owner"):
			var distance = target.global_position.distance_to(global_position)
			if distance > range:
				walk()
			else:
				if timer.is_stopped():
					timer.start()
	else:
		timer.stop()
func _input(event):
	show_range_handler()
	if Input.is_action_just_pressed(action):
		select_target()
	for cancelling_action in cancelling_actions:
		if Input.is_action_just_pressed(cancelling_action) or Input.is_action_just_released(cancelling_action):
			cancel()

func select_target():
	var camera = get_tree().get_nodes_in_group("camera")[0]
	var mousepos = get_viewport().get_mouse_position()
	var raylen = 1000
	var from = camera.project_ray_origin(mousepos)
	var to = from + camera.project_ray_normal(mousepos) * raylen
	var space = get_parent().get_world_3d().direct_space_state
	var rayquery = PhysicsRayQueryParameters3D.new()
	rayquery.from = from
	rayquery.to = to
	var result = space.intersect_ray(rayquery)
	if !result.is_empty():
		target = result.collider

func walk():
	nav_comp.select_destiny(target.position, range)

func attack():
	var atk = Attack.new()
	atk.atk_damage = atk_damage
	atk.caster = self
	target.damage(atk)

func timeout():
	timer.wait_time = atk_cooldown
	attack()
	

func show_range_handler():
	if Input.is_action_just_pressed("show_range"):
		range_show.visible = true
	if Input.is_action_just_released("show_range"):
		range_show.visible = false

func cancel():
	target = null
