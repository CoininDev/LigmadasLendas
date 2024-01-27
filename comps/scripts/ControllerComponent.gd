extends Node3D

@export var nav: NavigationComponent
@export var battack: BAttackComponent
@export var walk_action = "mright"
@export var attack_action = "mleft"


func _input(event):
	if Input.is_action_pressed(walk_action):
		#converter o ponto do mouse na tela 2d para um ponto 3d no jogo.
		#para isso é preciso criar um raio, uma linha reta que parte da camera e segue até encontrar uma colisão.
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
			nav.select_destiny(result.position, nav.desired_distance)
	
	if Input.is_action_just_pressed(attack_action):
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
		if !result.is_empty() && get_parent() != result.collider:
			if result.collider.is_in_group("hitbox_owner"):
				battack.target = result.collider
