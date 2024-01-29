extends Node3D
class_name HeroBase
@export var dmgr: DamageMgrComponent


var q = Ability.new
var w = Ability.new
var e = Ability.new
var r = Ability.new

@onready var q_caster = $AbilityCasters/Q

func damage(atk: Attack):
	dmgr.damage(atk)

func _process(delta):
	q.target_direction = q_caster.rotation
	print(q.target_direction)

func q_preview():
	q_caster.visible = true

func w_preview():
	pass

func e_preview():
	pass

func r_preview():
	pass

func d_preview():
	pass

func f_preview():
	pass



func q_cast():
	pass

func w_cast():
	pass

func e_cast():
	pass

func r_cast():
	pass

func d_cast():
	pass

func f_cast():
	pass
