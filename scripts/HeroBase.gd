class_name HeroBase
extends CharacterBody3D
@export var max_health = 100
@export var raw_armor = 25
@export var raw_magic_resistance = 25
@export var raw_psycho_resistance = 25
@export var raw_physic_power = 50
@export var raw_magic_power = 50
@export var raw_psycho_power = 50
@export var raw_speed = 750
var speed = raw_speed
var armor = raw_armor
var magic_resistance = raw_magic_resistance
var psycho_resistance = raw_psycho_resistance
var physic_power = raw_physic_power
var magic_power = raw_magic_power
var psycho_power = raw_psycho_power

var atk_target:Node

var mover = true

@export var effects = {
	"root":0.0,
	"silence":0.0,
	"slow":0.0,
	"taunt":0.0,
	"fear":0.0,
	"chant":0.0
}

@export var comps = {
	"nav": NavigationAgent3D.new(),
	"col": CollisionShape3D.new(),
	"gfx": MeshInstance3D.new()
}

func _ready():
	add_to_group("hero")
	comps["col"].shape = CylinderShape3D
	comps["nav"].path_desired_distance = 0.1
	comps["nav"].target_desired_distance = 0.1
	comps["col"].position.y = 1
	comps["gfx"].position.y = 1
	
	for comp in comps:
		#comps[comp].name = comps[comp].name + str(unique_token())
		add_child(comps[comp])
	#name = name +str(unique_token())
func _process(delta):
	print(atk_target)
	if not comps["nav"].is_navigation_finished() && mover:
		move(delta)
	
func _input(_e):
	select_move_destiny()
	select_atk_target()

#movement
func select_move_destiny():
	if Input.is_action_pressed("mright"):
		#converter o ponto do mouse na tela 2d para um ponto 3d no jogo.
		#para isso é preciso criar um raio, uma linha reta que parte da camera e segue até encontrar uma colisão.
		var camera = get_tree().get_nodes_in_group("camera")[0]
		var mousepos = get_viewport().get_mouse_position()
		var raylen = 1000
		var from = camera.project_ray_origin(mousepos)
		var to = from + camera.project_ray_normal(mousepos) * raylen
		var space = get_world_3d().direct_space_state
		var rayquery = PhysicsRayQueryParameters3D.new()
		rayquery.from = from
		rayquery.to = to
		var result = space.intersect_ray(rayquery)
		if !result.is_empty():
			comps["nav"].target_position = result.position
func move(delta):
	var targetpos = comps["nav"].get_next_path_position()
	var dir = global_position.direction_to(targetpos)
	look_at(Vector3(targetpos.x, global_position.y, targetpos.z), Vector3.UP)#olhar para a direção certa
	velocity = dir * speed * delta
	move_and_slide()

#attack
func select_atk_target():
	if Input.is_action_pressed("mleft"):
		#converter o ponto do mouse na tela 2d para um ponto 3d no jogo.
		#para isso é preciso criar um raio, uma linha reta que parte da camera e segue até encontrar uma colisão.
		var camera = get_tree().get_nodes_in_group("camera")[0]
		var mousepos = get_viewport().get_mouse_position()
		var raylen = 1000
		var from = camera.project_ray_origin(mousepos)
		var to = from + camera.project_ray_normal(mousepos) * raylen
		var space = get_world_3d().direct_space_state
		var rayquery = PhysicsRayQueryParameters3D.new()
		rayquery.from = from
		rayquery.to = to
		var result = space.intersect_ray(rayquery)
		if !result.is_empty():
			atk_target = result.collider


#id
func unique_token():
	var count = 0
	for node in get_parent().get_children():
		if node.is_in_group("hero"):
			count += 1
	return count
