extends NavigationAgent3D
class_name NavigationComponent

@export var speed = 500
@export var desired_distance:float = 1 
@export var hero:HeroBase
var blocked:bool = false
@export var mouse_mostrar:Node3D 

func _process(delta):
	mouse_mostrar.global_position = target_position
	if is_navigation_finished():
		mouse_mostrar.visible = false 
		return
	move(delta)

func select_destiny(position:Vector3, desired_distance:float):
	target_desired_distance = desired_distance
	target_position = position
	mouse_mostrar.visible = true

func ditch_destiny():
	target_position = hero.position

func move(delta):
	if not blocked:
		var current_pos = Vector3(hero.global_position.x, 1, hero.global_position.z)
		var next_path_pos = Vector3(get_next_path_position().x, 1, get_next_path_position().z)
		hero.velocity = current_pos.direction_to(next_path_pos) * speed * delta
		hero.move_and_slide()
		hero.look_at(next_path_pos, Vector3.UP)#olhar para a direção certa
		hero.rotation = Vector3.ZERO
