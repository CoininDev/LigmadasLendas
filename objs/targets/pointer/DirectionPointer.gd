extends Pointer

@export var mesh_instance:MeshInstance3D

func _process(delta):
	var result = GeneralFuncs.mouse_raycast()
	if result:
		look_at(result.position)
		rotation.x = 0
