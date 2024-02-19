extends Node3D
class_name Unit

@export_enum("blue", "red") var team:int = 0
var team_name:String
var enemy_team:int
var enemy_team_name:String

func _ready():
	match team:
		0:
			team_name = "blue"
			enemy_team = 1
			print("drop it like its hot")
		1:
			team_name = "red"
			enemy_team = 0

	match enemy_team:
		0:
			enemy_team_name = "blue"
		1:
			enemy_team_name = "red"
	
	
	add_to_group(team_name)


func _process(delta):
	pass
