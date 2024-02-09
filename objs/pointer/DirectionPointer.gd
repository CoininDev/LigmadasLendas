extends Pointer

func _process(delta):
	var result = GeneralFuncs.mouse_raycast()
	if result:
		look_at(result.position)
		rotation.x = 0
