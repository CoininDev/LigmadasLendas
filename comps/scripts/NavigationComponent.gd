extends NavigationAgent3D
class_name NavigationComponent

@export var speed = 10.0
@export var desired_distance:float = 1 
@export var hero:Node3D
@export var show_target_position:bool
var blocked:bool = false
var walking:bool = false
var walking_check:bool = false #usado para fazer o sinal walking changed funcionar
signal walking_changed
@onready var mouse_mostrar:Node3D = $MouseMostrar

func _ready():
	velocity_computed.connect(move)

func select_destiny(destiny_pos:Vector3, distance:float):
	set_path_desired_distance(desired_distance)
	set_target_desired_distance(distance)
	set_target_position(destiny_pos)

func select_destiny_path(destiny_pos:Vector3, distance:float):
	
	set_path_desired_distance(distance)
	set_target_position(destiny_pos)

func _physics_process(delta):
	if show_target_position: mouse_mostrar.visible = true
	mouse_mostrar.global_position = target_position
	if is_navigation_finished(): 
		if show_target_position: mouse_mostrar.visible = false
		walking = false
		return
	walking = true
	var next_pos = get_next_path_position()
	var dir = hero.global_position.direction_to(next_pos) * speed
	var new_vel = hero.velocity + (dir  - hero.velocity)
	set_velocity(new_vel)

func move(new_vel):
	hero.velocity = new_vel
	hero.move_and_slide()
	signal_walking_changed_handle()

func signal_walking_changed_handle():
	if walking != walking_check:
		walking_check = walking
		walking_changed.emit(walking)

#func _physics_process(delta):
	#mouse_mostrar.global_position = target_position
	#if is_navigation_finished():
		#mouse_mostrar.visible = false 
		#return
	#move(delta)
#
#func select_destiny(position:Vector3, distance:float):
	##path_desired_distance = distance
	#target_desired_distance = distance
	#target_position = position
	#mouse_mostrar.visible = true
#
func ditch_destiny():
	target_position = hero.global_position
#
#func move(delta):
	#if not blocked:
		#var current_pos = Vector3(hero.global_position.x, 1, hero.global_position.z)
		#var next_path_pos = Vector3(get_next_path_position().x, 1, get_next_path_position().z)
		#hero.velocity = current_pos.direction_to(next_path_pos) * speed * delta
		#hero.move_and_slide()
		#hero.look_at(next_path_pos, Vector3.UP)#olhar para a direção certa
		#hero.rotation = Vector3.ZERO
