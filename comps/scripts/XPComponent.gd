extends Node
class_name XPComponent

var level:int = 0
var level_max = 18  #0 1   2   3   4   5   6   7   8   9   10  11  12  13  14  15  16  17  18
var xp_needed_for = [0,100,120,140,150,160,230,240,250,260,270,280,300,310,320,330,340,350,380]

var ability1_lvl = 0
var ability2_lvl = 0
var ability3_lvl = 0
var ultimate_lvl = 0
var ability1_lvl_max = 5
var ability2_lvl_max = 5
var ability3_lvl_max = 5
var ultimate_lvl_max = 3


var current_xp:float = 0
var total_xp:float = 0

var upgrade_tokens:int = 0
var ultimate_upgrade_tokens:int = 0
@export var general_upgradable_atributes:Dictionary
@export var ability1_upgradable_atributes:Dictionary
@export var ability2_upgradable_atributes:Dictionary
@export var ability3_upgradable_atributes:Dictionary
@export var ultimate_upgradable_atributes:Dictionary
@export var hero:HeroBase

func add_xp(more_xp):
	current_xp += more_xp
	total_xp += more_xp
	if current_xp >= xp_needed_for[level+1]:
		level_up()

func level_up():
	if level < level_max:
		current_xp = 0
		level +=1
		upgrade_tokens +=1
		ultimate_upgrade_tokens +=1
		for upgradable in general_upgradable_atributes:
			hero.set(upgradable, general_upgradable_atributes[upgradable][level])

	
func ability1_lvl_up():
	if upgrade_tokens < 1:
		return
	upgrade_tokens -=1
	if ability1_lvl < ability1_lvl_max:
		ability1_lvl +=1
		for upgradable in ability1_upgradable_atributes:
			hero.set(upgradable, ability1_upgradable_atributes[upgradable][ability1_lvl])

func ability2_lvl_up():
	if upgrade_tokens < 1:
		return
	upgrade_tokens -=1
	if ability2_lvl < ability2_lvl_max:
		ability2_lvl +=1
		for upgradable in ability2_upgradable_atributes:
			hero.set(upgradable, ability2_upgradable_atributes[upgradable][ability2_lvl])

func ability3_lvl_up():
	if upgrade_tokens < 1:
		return
	upgrade_tokens -=1
	if ability3_lvl < ability3_lvl_max:
		ability3_lvl +=1
		for upgradable in ability3_upgradable_atributes:
			hero.set(upgradable, ability3_upgradable_atributes[upgradable][ability3_lvl])

func ultimate_lvl_up():
	if ultimate_upgrade_tokens < 6:
		return
	ultimate_upgrade_tokens -= 6
	if ultimate_lvl < ultimate_lvl_max:
		ultimate_lvl +=1
		for upgradable in ultimate_upgradable_atributes:
			hero.set(upgradable, ultimate_upgradable_atributes[upgradable][ultimate_lvl])
