extends Node3D
class_name HeroBase
@export var dmgr: DamageMgrComponent
@export var ability_box: Node3D
@export var q_p: Pointer
@export var w_p: Pointer
@export var e_p: Pointer
@export var r_p: Pointer

var q = Ability.new()
var w = Ability.new()
var e = Ability.new()
var r = Ability.new()



func damage(atk: Attack):
	dmgr.damage(atk)

func _ready():
	pass

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
