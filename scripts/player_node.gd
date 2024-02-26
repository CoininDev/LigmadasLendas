extends Node

@export var player_id = 1:
    set(id):
        player_id = id
        $PlayerInput.set_multiplayer_authority(id)


@export var ability_box:Node
@export var spawn_point_position:Vector3 = Vector3.ZERO
@export var character_name:String = "Alyssa"
@export var team:TeamComponent.TeamName = TeamComponent.TeamName.blue

func _ready()->void:
    var hero:HeroBase = $Hero
    hero.set_script(load(HeroesDict.get_hero_script(character_name)))
    ## Setting character points
    print(hero.has_method("_on_ult_timer_timeout"))
    
    hero.ability_box = ability_box
    hero.spawn_point = $SpawnPoint
    
    ## Setting characters
    hero.dmgr = $Hero/comps/DamageMgrComponent
    hero.xp_comp = $Hero/comps/XPComponent
    hero.batk_comp = $Hero/comps/BAttackComponent
    hero.fx_comp = $Hero/comps/EffectsComponent
    hero.anim_comp = $Hero/comps/AnimationComponent
    hero.state_machine_comp = $Hero/comps/StateMachineComponent
    hero.alive_state = $Hero/comps/StateMachineComponent/HeroAliveState
    hero.alive_state.player_input = $PlayerInput
    hero.team_comp = $Hero/comps/TeamComponent
    hero.team_comp.team = team
    add_child(hero)
    $CameraMan.point = hero
