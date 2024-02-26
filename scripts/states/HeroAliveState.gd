extends State
class_name HeroAliveState
# Ele vai substituir o ControllerComponent :)

@export var nav: NavigationComponent
@export var battack: BAttackComponent
@export var sanity: SanityComponent
@export var xp_comp: XPComponent
@export var hero: HeroBase
@export var hero_col:CollisionShape3D
@export var health_comp:HealthComponent
@export var player_input:PlayerInput



func enter():
    health_comp.health = health_comp.MAX_HEALTH
    sanity.timer.start()
    hero.global_position = hero.spawn_point.global_position
    hero_col.disabled = false

func physics_update(_delta:float):
    if Input.is_action_just_pressed("p"):
        var atk = Attack.new()
        atk.physic_damage = 50
        atk.caster = hero
        health_comp.ignore_resistance_damage(atk)
        #hero.ability_power += 100
    upgrade_abilities()
    abilities()
    attack()
    walk()

func upgrade_abilities():
    if player_input.lvl_up_ability_pressed[0]:
        xp_comp.ability1_lvl_up()
    if player_input.lvl_up_ability_pressed[1]:
        xp_comp.ability2_lvl_up()
    if player_input.lvl_up_ability_pressed[2]:
        xp_comp.ability3_lvl_up()
    if player_input.lvl_up_ability_pressed[3]:
        xp_comp.ultimate_lvl_up()


func abilities():
    if Input.is_action_pressed("ctrl"): return
    if player_input.ability_pressed[0]:    
        hero.q_preview()
    if player_input.ability_pressed[1]:
        hero.w_preview()
    if player_input.ability_pressed[2]:
        hero.e_preview()
    if player_input.ability_pressed[3]:
        hero.r_preview()
    if player_input.ability_pressed[4]:
        hero.a_preview()
    if player_input.ability_pressed[5]:
        hero.s_preview()
    
    if player_input.ability_released[0]:
        hero.q_cast()
    if player_input.ability_released[1]:
        hero.w_cast()
    if player_input.ability_released[2]:
        hero.e_cast()
    if player_input.ability_released[3]:
        hero.r_cast()
    if player_input.ability_released[4]:
        hero.a_cast()
    if player_input.ability_released[5]:
        hero.s_cast()

func walk():
    if player_input.walk_pressed:
        var result = GeneralFuncs.mouse_raycast()
        if result:
            nav.select_destiny(result.position, nav.desired_distance)

func attack():
    if player_input.show_range_pressed:
        battack.visible = true
    else:
        battack.visible = false
    if player_input.attack_pressed:
        var result = GeneralFuncs.mouse_raycast_entity()
        if result:
            if !result.collider.is_in_group(hero.team_comp.team_str):
                battack.select_target(result.collider)
