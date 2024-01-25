extends NavigationAgent3D

@export var speed = 500
@export var action = "mright"

func _process(delta):
	if is_navigation_finished():
		return
	move(delta)

func _input(_event):
	select_destiny_move()
#movimento
func select_destiny_move():
	if Input.is_action_pressed(action):
		#converter o ponto do mouse na tela 2d para um ponto 3d no jogo.
		#para isso é preciso criar um raio, uma linha reta que parte da camera e segue até encontrar uma colisão.
		var camera = get_tree().get_nodes_in_group("camera")[0]
		var mousepos = get_viewport().get_mouse_position()
		var raylen = 1000
		var from = camera.project_ray_origin(mousepos)
		var to = from + camera.project_ray_normal(mousepos) * raylen
		var space = get_parent().get_world_3d().direct_space_state
		var rayquery = PhysicsRayQueryParameters3D.new()
		rayquery.from = from
		rayquery.to = to
		var result = space.intersect_ray(rayquery)
		if !result.is_empty():
			target_position = result.position
func move(delta):
	var current_pos = Vector3(get_parent().global_position.x, 1, get_parent().global_position.z)
	var next_path_pos = Vector3(get_next_path_position().x, 1, get_next_path_position().z)
	get_parent().velocity = current_pos.direction_to(next_path_pos) * speed * delta
	get_parent().move_and_slide()
	
	get_parent().look_at(next_path_pos, Vector3.UP)#olhar para a direção certa
