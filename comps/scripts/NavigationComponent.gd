extends NavigationAgent3D
class_name NavigationComponent

@export var speed = 10.0
@export var desired_distance:float = 1 
@export var hero:HeroBase
var blocked:bool = false
@export var mouse_mostrar:Node3D 

func _ready():
	velocity_computed.connect(move)

func select_destiny(destiny_pos:Vector3, distance:float):
	set_target_position(destiny_pos)

func _physics_process(delta):
	mouse_mostrar.visible = true
	mouse_mostrar.global_position = target_position
	if is_navigation_finished(): 
		mouse_mostrar.visible = false
		return
	
	var next_pos = get_next_path_position()
	var dir = hero.global_position.direction_to(next_pos) * speed
	var new_vel = hero.velocity + (dir  - hero.velocity)
	set_velocity(new_vel)

func move(new_vel):
	hero.velocity = new_vel
	hero.move_and_slide()

#var movement_speed: float = 3.0
#
#func _ready():
	## These values need to be adjusted for the actor's speed
	## and the navigation layout.
	#path_desired_distance = 1
	#target_desired_distance = 0.1
#
	## Make sure to not await during _ready.
	#call_deferred("actor_setup")
#
#func actor_setup():
	#await get_tree().physics_frame
#
#func select_destiny(movement_target: Vector3, _a):
	#set_target_position(movement_target)
#
#func _physics_process(delta):
	#if is_navigation_finished():
		#return
#
	#var current_agent_position: Vector3 = hero.global_position
	#var next_path_position: Vector3 = get_next_path_position()
#
	#hero.velocity = current_agent_position.direction_to(next_path_position) * movement_speed
	#hero.move_and_slide()
