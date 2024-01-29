extends Node3D

@export var nav: NavigationComponent
@export var battack: BAttackComponent
@export var walk_action = "mright"
@export var attack_action = "mleft"
@export var hero: HeroBase

func _input(event):
	abilities()
	walk()
	attack()

func abilities():
	if Input.is_action_just_pressed("q"):
		hero.q_preview()
	if Input.is_action_just_pressed("w"):
		hero.w_preview()
	if Input.is_action_just_pressed("e"):
		hero.e_preview()
	if Input.is_action_just_pressed("r"):
		hero.r_preview()
	if Input.is_action_just_pressed("d"):
		hero.d_preview()
	if Input.is_action_just_pressed("f"):
		hero.f_preview()
	
	if Input.is_action_just_released("q"):
		hero.q_cast()
	if Input.is_action_just_released("w"):
		hero.w_cast()
	if Input.is_action_just_released("e"):
		hero.w_cast()
	if Input.is_action_just_released("r"):
		hero.w_cast()
	if Input.is_action_just_released("d"):
		hero.w_cast()
	if Input.is_action_just_released("f"):
		hero.w_cast()

func walk():
	if Input.is_action_pressed(walk_action):
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
			nav.select_destiny(result.position, nav.desired_distance)

func attack():
	if Input.is_action_just_pressed(attack_action):
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
		if !result.is_empty() && get_parent() != result.collider:
			if result.collider.is_in_group("hitbox_owner"):
				battack.target = result.collider
