extends Control
@export var camera:Camera3D
@onready var label = $Label
@onready var label2 = $Label2
@onready var label3 = $Label3
@onready var hero = $"../../".point

func _input(event):
	if !event is InputEventMouseMotion:
		label.text = event.as_text()

func _process(delta):
	#label2.text = "xp:" + str(hero.xp_comp.total_xp) + " lvl:" + str(hero.xp_comp.level) + " tk:" + str(hero.xp_comp.upgrade_tokens)
	#label3.text = str(hero.q_dano) + " " + str(hero.w_dano) + " " + str(hero.e_dano) + " " + str(hero.ult_buff*100)
	pass
