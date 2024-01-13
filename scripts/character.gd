extends CharacterBody3D
@export var speed = 500
@onready var navagent = $NavigationAgent3D

#funções centrais
func _process(delta):
	if navagent.is_navigation_finished():
		return
	move(delta)
func _input(event):
	select_target()
#funções específicas
func select_target():
	
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
		print(result)
		if result.has("position"):
			navagent.target_position = result.position
func move(delta):
	var targetpos = navagent.get_next_path_position()
	var dir = global_position.direction_to(targetpos)
	velocity = dir * speed * delta
	move_and_slide()
