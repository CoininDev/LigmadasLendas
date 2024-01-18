extends Node3D

func _input(event):
	if Input.is_action_just_pressed("cu"):
		get_tree().quit()
