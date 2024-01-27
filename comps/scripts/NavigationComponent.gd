extends NavigationAgent3D
class_name NavigationComponent

@export var speed = 500
@export var action = "mright"
@export var desired_distance:float = 1

func _process(delta):
	if is_navigation_finished():
		return
	move(delta)

func select_destiny(position:Vector3, desired_distance:float):
	path_desired_distance = desired_distance
	target_position = position

func move(delta):
	var current_pos = Vector3(get_parent().global_position.x, 1, get_parent().global_position.z)
	var next_path_pos = Vector3(get_next_path_position().x, 1, get_next_path_position().z)
	get_parent().velocity = current_pos.direction_to(next_path_pos) * speed * delta
	get_parent().move_and_slide()
	
	get_parent().look_at(next_path_pos, Vector3.UP)#olhar para a direção certa
