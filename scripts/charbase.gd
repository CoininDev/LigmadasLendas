extends CharacterBody3D
@export var max_health = 100
@export var raw_armor = 25
@export var raw_magic_resistance = 25
@export var raw_psycho_resistance = 25
@export var raw_physic_power = 50
@export var raw_magic_power = 50
@export var raw_psycho_power = 50
@export var raw_speed = 500
var speed = raw_speed
var armor = raw_armor
var magic_resistance = raw_magic_resistance
var psycho_resistance = raw_psycho_resistance
var physic_power = raw_physic_power
var magic_power = raw_magic_power
var psycho_power = raw_psycho_power



@export var effects = {
	"marca": false
}
@onready var navagent = $NavigationAgent3D
#funções centrais
func _process(delta):
	if navagent.is_navigation_finished():
		return
	move(delta)
	
	
func _input(_event):
	select_destiny_move()
#movimento
func select_destiny_move():
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
		if result.has("position"):
			navagent.target_position = result.position
func move(delta):
	var targetpos = navagent.get_next_path_position()
	var dir = global_position.direction_to(targetpos)
	look_at(Vector3(targetpos.x, global_position.y, targetpos.z), Vector3.UP)#olhar para a direção certa
	velocity = dir * speed * delta
	move_and_slide()
