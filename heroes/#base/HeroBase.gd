class_name HeroBase
extends CharacterBody3D
###########################
## PARAMETERS
###########################

@export_category("Points")
@export var ability_box: Node
@export var spawn_point: Node3D

@export_category("Components")
@export var dmgr: DamageMgrComponent
@export var xp_comp:XPComponent
@export var batk_comp:BAttackComponent
@export var fx_comp:EffectsComponent
@export var anim_comp:AnimationComponent
@export var state_machine_comp:StateMachineComponent
@export var alive_state:HeroAliveState
@export var team_comp:TeamComponent
@export var abilities_comp:AbilitiesComponent

@export_category("Abilities")
@export var pointer:NewPointer



#######################
## VARIABLES
#######################

var specified_script_entered:bool = false #feito para setar o herói que ele vai virar, funciona como um segundo _ready

# cooldown and block abilities parameters
var q_cooldown = Timer.new()
var w_cooldown = Timer.new()
var e_cooldown = Timer.new()
var r_cooldown = Timer.new()
var opt1_cooldown = Timer.new()
var opt2_cooldown = Timer.new()
var q_cooldown_block = false
var w_cooldown_block = false
var e_cooldown_block = false
var r_cooldown_block = false
var opt1_cooldown_block = false
var opt2_cooldown_block = false
var q_block = true
var w_block = true
var e_block = true
var r_block = true
var opt1_block = true
var opt2_block = true

var silenced = false

#game stats
var ultimoAlvo:Node3D
var buff:float = 1

#game attributes
var ability_power:float = 0
var gold:float = 0


#####################
## FUNCTIONS
#####################
func _ready():
    xp_comp.add_xp(100)
    q_cooldown.one_shot = true
    w_cooldown.one_shot = true
    e_cooldown.one_shot = true
    r_cooldown.one_shot = true
    opt1_cooldown.one_shot = true
    opt2_cooldown.one_shot = true
    q_cooldown.timeout.connect(_on_q_cooldown_timeout)
    w_cooldown.timeout.connect(_on_w_cooldown_timeout)
    e_cooldown.timeout.connect(_on_e_cooldown_timeout)
    r_cooldown.timeout.connect(_on_r_cooldown_timeout)
    opt1_cooldown.timeout.connect(_on_opt1_cooldown_timeout)
    opt2_cooldown.timeout.connect(_on_opt2_cooldown_timeout)
    add_child(q_cooldown)
    add_child(w_cooldown)
    add_child(e_cooldown)
    add_child(r_cooldown)
    add_child(opt1_cooldown)
    add_child(opt2_cooldown)
    print("ready generico")


func _process(delta:float):
    if xp_comp.ability1_lvl >0:
        print("unblocked")
        q_block = false
    if xp_comp.ability2_lvl >0:
        w_block = false
    if xp_comp.ability3_lvl >0:
        e_block = false
    if xp_comp.ultimate_lvl >0:
        r_block = false
    
    abilities_comp.update(delta)
#
#func q_preview():
    #pass
#func w_preview():
    #pass
#func e_preview():
    #pass
#func r_preview():
    #pass
#func a_preview():
    #pass
#func s_preview():
    #pass
#
#func q_cast():
    #pass
#func w_cast():
    #pass
#func e_cast():
    #pass
#func r_cast():
    #pass
#func a_cast():
    #pass
#func s_cast():
    #pass

func is_blocked(x:String) -> bool:
    if get(x+"_cooldown_block") or get(x+"_block") or silenced: return true
    return false

func start_cooldown(x:String, cooldown_time:float):
    set(x+"_cooldown_block", true)
    get(x+"_cooldown").start(cooldown_time)

func _on_q_cooldown_timeout():
    q_cooldown_block = false

func _on_w_cooldown_timeout():
    w_cooldown_block = false

func _on_e_cooldown_timeout():
    e_cooldown_block = false

func _on_r_cooldown_timeout():
    r_cooldown_block = false

func _on_opt1_cooldown_timeout():
    opt1_cooldown_block = false

func _on_opt2_cooldown_timeout():
    opt2_cooldown_block = false

func cancel():
    batk_comp.cancel() 

func die(_self:Node3D):
    var alive_state:State
    for state in state_machine_comp.get_children():
        if state.name.to_lower() == "heroalivestate":
            alive_state = state
    alive_state.transitioned.emit(alive_state, "herodeadstate")

func last_hitted(loot:Dictionary):
    xp_comp.add_xp(loot["xp"])
    gold += loot["gold"]

func target_died(target:Node3D):
    if batk_comp.target == target:
        batk_comp.cancel()
