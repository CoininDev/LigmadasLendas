extends MultiplayerSynchronizer
class_name PlayerInput

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

var walk_pressed:bool = false
var attack_pressed:bool = false
var ability_pressed:Array = [false,false,false,false,false,false]
var ability_released:Array = [false,false,false,false,false,false]

var lvl_up_ability_pressed:Array = [false,false,false,false]

var show_range_pressed:bool = false

func _input(_event):
    walk_pressed = Input.is_action_pressed(walk_action)
    attack_pressed = Input.is_action_just_pressed(attack_action)
    show_range_pressed = Input.is_action_just_pressed(show_attack_range_action)

    ability_pressed = [
        Input.is_action_just_pressed(ability1_action),
        Input.is_action_just_pressed(ability2_action),
        Input.is_action_just_pressed(ability3_action),
        Input.is_action_just_pressed(ultimate_action),
        Input.is_action_just_pressed(opt_ability1_action),
        Input.is_action_just_pressed(opt_ability2_action)
    ]

    ability_released = [
        Input.is_action_just_released(ability1_action),
        Input.is_action_just_released(ability2_action),
        Input.is_action_just_released(ability3_action),
        Input.is_action_just_released(ultimate_action),
        Input.is_action_just_released(opt_ability1_action),
        Input.is_action_just_released(opt_ability2_action)
    ]

    lvl_up_ability_pressed = [
        Input.is_action_just_pressed(upgrade_ability1_action),
        Input.is_action_just_pressed(upgrade_ability2_action),
        Input.is_action_just_pressed(upgrade_ability3_action),
        Input.is_action_just_pressed(upgrade_ultimate_action)
    ]
