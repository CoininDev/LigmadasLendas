extends Pointer

@export var mesh_instance:MeshInstance3D

func _process(delta):
	var camera = get_tree().get_nodes_in_group("camera")[0]
	var mousepos = get_viewport().get_mouse_position()
	var raylen = 1000
	var from = camera.project_ray_origin(mousepos)
	var to = from + camera.project_ray_normal(mousepos) * raylen
	var space = get_parent().get_world_3d().direct_space_state
	var rayquery = PhysicsRayQueryParameters3D.new()
	rayquery.collision_mask = 1
	rayquery.from = from
	rayquery.to = to
	var result = space.intersect_ray(rayquery)
	if !result.is_empty():
		look_at(result.position)
		rotation.x = 0
