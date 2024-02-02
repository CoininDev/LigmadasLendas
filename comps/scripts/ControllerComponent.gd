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
	if Input.is_action_just_pressed("a"):
		hero.a_preview()
	
	if Input.is_action_just_released("q"):
		hero.q_cast()
	if Input.is_action_just_released("w"):
		hero.w_cast()
	if Input.is_action_just_released("e"):
		hero.e_cast()
	if Input.is_action_just_released("r"):
		hero.r_cast()
	if Input.is_action_just_released("a"):
		hero.a_cast()

func walk():
	if Input.is_action_pressed(walk_action):
		var result = GeneralFuncs.mouse_raycast()
		if result:
			nav.select_destiny(result.position, nav.desired_distance)

func attack():
	if Input.is_action_just_pressed(attack_action):
		var result = GeneralFuncs.mouse_raycast()
		if result:
			if get_parent() != result.collider && result.collider.is_in_group("hitbox_owner"):
				battack.select_target(result.collider)
