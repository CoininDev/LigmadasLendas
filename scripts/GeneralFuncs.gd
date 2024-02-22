extends Node

var creep_count:int = 0

func mouse_raycast():
	#converter o ponto do mouse na tela 2d para um ponto 3d no jogo.
	#para isso é preciso criar um raio, uma linha reta que parte da camera e segue até encontrar uma colisão.
	var camera = get_viewport().get_camera_3d()
	var mousepos = get_viewport().get_mouse_position()
	var raylen = 1000
	var from = camera.project_ray_origin(mousepos)
	var to = from + camera.project_ray_normal(mousepos) * raylen
	var space = get_parent().get_world_3d().direct_space_state
	var rayquery = PhysicsRayQueryParameters3D.new()
	rayquery.collision_mask = 4 #colide com o chao (layer 3)
	rayquery.from = from
	rayquery.to = to
	var result = space.intersect_ray(rayquery)
	return result

func mouse_raycast_entity():
	var camera = get_viewport().get_camera_3d()
	var mousepos = get_viewport().get_mouse_position()
	var raylen = 1000
	var from = camera.project_ray_origin(mousepos)
	var to = from + camera.project_ray_normal(mousepos) * raylen
	var space = get_parent().get_world_3d().direct_space_state
	var rayquery = PhysicsRayQueryParameters3D.new()
	rayquery.collision_mask = 1 #colide com entidades (layer 1)
	rayquery.from = from
	rayquery.to = to
	var result = space.intersect_ray(rayquery)
	return result

func mouse_raycast_all():
	var camera = get_viewport().get_camera_3d()
	var mousepos = get_viewport().get_mouse_position()
	var raylen = 1000
	var from = camera.project_ray_origin(mousepos)
	var to = from + camera.project_ray_normal(mousepos) * raylen
	var space = get_parent().get_world_3d().direct_space_state
	var rayquery = PhysicsRayQueryParameters3D.new()
	rayquery.from = from
	rayquery.to = to
	var result = space.intersect_ray(rayquery)
	return result

func _process(delta):
	print("Creep Count: %d" % creep_count)
	
