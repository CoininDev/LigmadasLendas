extends CharacterBody3D
class_name HeroBase
@export var dmgr: DamageMgrComponent
@export var xp_comp:XPComponent
@export var batk_comp:BAttackComponent
@export var fx_comp:EffectsComponent
@export var anim_comp:AnimationComponent
@export var state_machine_comp:StateMachineComponent
@export var team_comp:TeamComponent
@export var ability_box: Node3D
@export var spawn_point: Node3D
@export var q_p:Pointer
@export var w_p:Pointer
@export var e_p:Pointer
@export var r_p:Pointer
var q_cooldown = Timer.new()
var w_cooldown = Timer.new()
var e_cooldown = Timer.new()
var r_cooldown = Timer.new()
var q_cooldown_block = false
var w_cooldown_block = false
var e_cooldown_block = false
var r_cooldown_block = false

var type = "hero"
var ultimoAlvo:Node3D

var buff:float = 1
var ability_power:float = 0

var q = Ability.new() 
var w = Ability.new()
var e = Ability.new()
var r = Ability.new()
var p = Ability.new()


func _ready_base():
	xp_comp.add_xp(100)

func _process(delta):
	pass

func q_preview():
	pass

func w_preview():
	pass

func e_preview():
	pass

func r_preview():
	pass

func a_preview():
	pass

func s_preview():
	pass

func q_cast():
	pass

func w_cast():
	pass

func e_cast():
	pass

func r_cast():
	pass

func a_cast():
	pass

func s_cast():
	pass

func _on_q_cooldown_timeout():
	q_cooldown_block = false

func _on_w_cooldown_timeout():
	w_cooldown_block = false

func _on_e_cooldown_timeout():
	e_cooldown_block = false

func _on_r_cooldown_timeout():
	r_cooldown_block = false

func add_xp(xp):
	xp_comp.add_xp(xp)

func cancel():
	batk_comp.cancel() 

func die():
	var alive_state:State
	for state in state_machine_comp.get_children():
		if state.name.to_lower() == "heroalivestate":
			alive_state = state
	alive_state.transitioned.emit(alive_state, "herodeadstate")
