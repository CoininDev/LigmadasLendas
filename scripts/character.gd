extends CharacterBody3D

@onready var navagent = $NavigationAgent3D


func _input(event):
	if Input.is_action_just_pressed("mright"):
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
		#mover até o ponto encontrado
		print(result)
