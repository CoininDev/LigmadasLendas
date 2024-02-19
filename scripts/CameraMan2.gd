extends Node3D

@onready var camera = $Elevation/Camera3D

#########################
## PARAMS
#########################
#move
@export var speed = 10
#zoom
@export var min_zoom_out = 2
@export var max_zoom_out = 90
@export var zoom_speed = 10
#rotation
@export var min_angle = 10
@export var max_angle = 75
@export var rotation_speed = 0.2
#lock_in_object
@export var point:Node3D
@export var smoth_speed = 15
var lock_cam:bool = true
var lock_cam_persist:bool

func _ready():
	pass

func _process(delta):
	if lock_cam:
		global_position = lerp(global_position, point.global_position, smoth_speed * delta)
		#global_position = point.global_position
		return
	move(delta)

func _input(event):
	zoom()
	rotate_camera(event)
	lock_cam = Input.is_action_pressed("space") or lock_cam_persist
	if Input.is_action_just_pressed("lock_camera"):
		lock_cam_persist = !lock_cam_persist

func move(delta:float):
	var dir:Vector3  = Vector3(Input.get_axis("ui_left","ui_right"), 0, Input.get_axis("ui_up", "ui_down")).normalized()
	position += dir * delta * speed 

func zoom():
	#zoom in
	if Input.is_action_pressed("scroll_up"):
		if camera.position.z > min_zoom_out:
			camera.position.z -= 1
			speed -= 3
	
	#zoom out
	if Input.is_action_pressed("scroll_down"):
		if camera.position.z < max_zoom_out:
			camera.position.z += 1
			speed += 3

func rotate_camera(event:InputEvent):
	if Input.is_action_pressed("rotate_camera"):
		if event is InputEventMouseMotion:
			$Elevation.rotation_degrees.x -= event.relative.y * rotation_speed
			$Elevation.rotation_degrees.x = clamp($Elevation.rotation_degrees.x, -max_angle, -min_angle)
			Input.mouse_mode = 2
			rotation_degrees.y -= event.relative.x * rotation_speed
	else:
		Input.mouse_mode = 0
