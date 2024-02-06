extends CharacterBody3D
var speed = 40
const JUMP_VELOCITY = 4.5
@onready var camera = $Camera3D


@export var point:Node3D
var point_offset = Vector3(0,15,5)
var smooth_speed = 20
var lock_camera = false
@export var max_zoom:float = 10


var up = false
var down = false
var right = false
var left = false

func _ready():
	camera.position.z = -3

func _process(delta):
	if lock_camera:
			global_position = lerp(global_position, point.global_position + point_offset, smooth_speed * delta)
	else:
		move()

func _input(event):
	zoom()
	lock()

func zoom():
	if Input.is_action_pressed("scroll_up"):
		if camera.position.z > -max_zoom:
			camera.position.z -= 1
			speed -= 3
			
	if Input.is_action_pressed("scroll_down"):
		if camera.position.z <= 0:
			camera.position.z += 1
			speed += 3

func lock():
	if Input.is_action_just_pressed("space"):
		lock_camera = true
	if Input.is_action_just_released("space"):
		lock_camera = false

func move():
	var input_dir = Vector3((int(right)-int(left)), 0, (int(down)-int(up)))
	#var input_dir = Vector3((int(Input.is_action_pressed("ui_right"))-int(Input.is_action_pressed("ui_left"))), 0, (int(Input.is_action_pressed("ui_up"))-int(Input.is_action_pressed("ui_down"))))
	var direction = (transform.basis * input_dir).normalized()
	if direction:
		velocity.x = direction.x * speed 
		velocity.z = direction.z * speed *3
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
		velocity.z = move_toward(velocity.z, 0, speed)
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
