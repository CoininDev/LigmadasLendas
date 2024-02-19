extends Node
class_name TeamComponent

enum TeamName{
	blue,
	red
}

@export var team:TeamName = 0
@export var hero:Node3D
var enemy_team:TeamName
var team_str:String
var enemy_team_str:String

func _ready():
	enemy_team = int(!bool(team)) #oposto 0=1, 1=0
	enemy_team_str = str(enemy_team)
	team_str = str(team)
	hero.add_to_group(team_str)
	print(hero.name + " added to " + str(team) + " team.")
