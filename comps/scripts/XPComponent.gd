extends Node3D
class_name XPComponent

var level:int = 0
var level_max = 1

var ability1_lvl = 0
var ability2_lvl = 0
var ability3_lvl = 0
var ultimate_lvl = 0
var ability1_lvl_max = 5
var ability2_lvl_max = 5
var ability3_lvl_max = 5
var ultimate_lvl_max = 3


var xp_atual:float = 0
var xp_total:float = 0

@export var general_upgradable_atributes:Dictionary
@export var ability1_upgradable_atributes:Dictionary
@export var ability2_upgradable_atributes:Dictionary
@export var ability3_upgradable_atributes:Dictionary
@export var ultimate_upgradable_atributes:Dictionary
@export var hero:HeroBase

func add_xp(more_xp):
	xp_atual += more_xp
	xp_total += more_xp
	if xp_atual >= 100:
		level_up()

func level_up():
	if level < level_max:
		xp_atual = 0
		level +=1
	for upgradable in general_upgradable_atributes:
		print(level)
		print(upgradable)
		print(general_upgradable_atributes)
		print(general_upgradable_atributes[upgradable][level])
		hero.set(upgradable, general_upgradable_atributes[upgradable][level])

	
func ability1_lvl_up():
	if ability1_lvl < ability1_lvl_max:
		ability1_lvl +=1
	for upgradable in ability1_upgradable_atributes:
		print(level)
		print(upgradable)
		print(ability1_upgradable_atributes)
		print(ability1_upgradable_atributes[upgradable][level])
		hero.set(upgradable, ability1_upgradable_atributes[upgradable][level])

func ability2_lvl_up():
	if ability2_lvl < ability2_lvl_max:
		ability2_lvl +=1
	for upgradable in ability2_upgradable_atributes:
		print(level)
		print(upgradable)
		print(ability2_upgradable_atributes)
		print(ability2_upgradable_atributes[upgradable][level])
		hero.set(upgradable, ability2_upgradable_atributes[upgradable][level])

func ability3_lvl_up():
	if ability3_lvl < ability3_lvl_max:
		ability3_lvl +=1
	for upgradable in ability3_upgradable_atributes:
		print(level)
		print(upgradable)
		print(ability3_upgradable_atributes)
		print(ability3_upgradable_atributes[upgradable][level])
		hero.set(upgradable, ability3_upgradable_atributes[upgradable][level])

func ultimate_lvl_up():
	if ultimate_lvl < ultimate_lvl_max:
		ultimate_lvl +=1
	for upgradable in ultimate_upgradable_atributes:
		print(level)
		print(upgradable)
		print(ultimate_upgradable_atributes)
		print(ultimate_upgradable_atributes[upgradable][level])
		hero.set(upgradable, ultimate_upgradable_atributes[upgradable][level])
