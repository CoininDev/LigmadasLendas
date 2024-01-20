extends CharacterBody3D
const SPEED = 50
const JUMP_VELOCITY = 4.5

var up = false
var down = false
var right = false
var left = false

func _process(delta):
	var input_dir = Vector3((int(right)-int(left)), 0, (int(down)-int(up)))
	#var input_dir = Vector3((int(Input.is_action_pressed("ui_right"))-int(Input.is_action_pressed("ui_left"))), 0, (int(Input.is_action_pressed("ui_up"))-int(Input.is_action_pressed("ui_down"))))
	var direction = (transform.basis * input_dir).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()

#cantos únicos
func _on_up_mouse_entered():
	up=true
func _on_down_mouse_entered():
	down=true
func _on_right_mouse_entered():
	right=true
func _on_left_mouse_entered():
	left=true
func _on_up_mouse_exited():
	up=false
func _on_down_mouse_exited():
	down=false
func _on_right_mouse_exited():
	right=false
func _on_left_mouse_exited():
	left=false

func _on_up_right_mouse_entered():
	up = true
	right = true
func _on_up_left_mouse_entered():
	up = true
	left = true
func _on_down_right_mouse_entered():
	down = true
	right = true
func _on_down_left_mouse_entered():
	down = true
	left = true
func _on_up_right_mouse_exited():
	up = false
	right = false
func _on_up_left_mouse_exited():
	up = false
	left = false
func _on_down_right_mouse_exited():
	down = false
	right = false
func _on_down_left_mouse_exited():
	down = false
	left = false
