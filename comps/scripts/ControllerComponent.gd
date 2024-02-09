extends Node

@export var nav: NavigationComponent
@export var battack: BAttackComponent
@export var xp_comp: XPComponent
@export var hero: HeroBase
@export var control: bool = true
@export var walk_action = "mright"
@export var attack_action = "mleft"
@export var show_attack_range_action = "show_range"
@export var ability1_action = "q"
@export var ability2_action = "w"
@export var ability3_action = "e"
@export var ultimate_action = "r"
@export var upgrade_ability1_action = "ctrl_q"
@export var upgrade_ability2_action = "ctrl_w"
@export var upgrade_ability3_action = "ctrl_e"
@export var upgrade_ultimate_action = "ctrl_r"
@export var opt_ability1_action = "a"
@export var opt_ability2_action = "s"

func _input(event):
	if control:
		upgrade_abilities()
		abilities()
		attack()
		walk()

func upgrade_abilities():
	if Input.is_action_just_pressed(upgrade_ability1_action):
		xp_comp.ability1_lvl_up()
	if Input.is_action_just_pressed(upgrade_ability2_action):
		xp_comp.ability2_lvl_up()
	if Input.is_action_just_pressed(upgrade_ability3_action):
		xp_comp.ability3_lvl_up()
	if Input.is_action_just_pressed(upgrade_ultimate_action):
		xp_comp.ultimate_lvl_up()


func abilities():
	if Input.is_action_pressed("ctrl"):
		return
	
	if Input.is_action_just_pressed(ability1_action):
		hero.q_preview()
	if Input.is_action_just_pressed(ability2_action):
		hero.w_preview()
	if Input.is_action_just_pressed(ability3_action):
		hero.e_preview()
	if Input.is_action_just_pressed(ultimate_action):
		hero.r_preview()
	if Input.is_action_just_pressed(opt_ability1_action):
		hero.a_preview()
	if Input.is_action_just_pressed(opt_ability2_action):
		hero.s_preview()
	
	if Input.is_action_just_released(ability1_action):
		hero.q_cast()
	if Input.is_action_just_released(ability2_action):
		hero.w_cast()
	if Input.is_action_just_released(ability3_action):
		hero.e_cast()
	if Input.is_action_just_released(ultimate_action):
		hero.r_cast()
	if Input.is_action_just_released(opt_ability1_action):
		hero.a_cast()
	if Input.is_action_just_pressed(opt_ability2_action):
		hero.s_cast()

func walk():
	if Input.is_action_pressed(walk_action):
		var result = GeneralFuncs.mouse_raycast()
		if result:
			nav.select_destiny(result.position, nav.desired_distance)

func attack():
	if Input.is_action_just_pressed(show_attack_range_action):
		battack.visible = true
	if Input.is_action_just_released(show_attack_range_action):
		battack.visible = false
	if Input.is_action_just_pressed(attack_action):
		var result = GeneralFuncs.mouse_raycast_all()
		if result:
			if get_parent() != result.collider && result.collider:
				battack.select_target(result.collider)
