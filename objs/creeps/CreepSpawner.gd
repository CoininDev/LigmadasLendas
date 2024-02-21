extends Node
class_name CreepSpawner
@export var time:float = 30
@export var blue_core:Core
@export var red_core:Core
@export var creep_box:Node
var time_countdown:float
var melee_creep_scene:PackedScene = load("res://objs/creeps/melee_creep.tscn")

func _ready():
	time_countdown = time 

func _process(delta):
	time_countdown -= delta
	if time_countdown <= 0:
		time_countdown = time 
		for team_node in get_children():
			var valid_teams:Array = ["blue", "red", "neutral"]
			if valid_teams.has(team_node.name.to_lower()):
				for point in team_node.get_children():
					var creep:Creep = create_creep(valid_teams.bsearch(team_node.name.to_lower()), point.get_groups()[0])
					add_child(creep)
					creep.global_position = point.global_position
			#if point.is_in_group("melee_creep"):
				#var melee_creep = melee_creep_scene.instantiate()
				#if point.is_in_group("0"):#azul
					#melee_creep.enemy_core = red_core
					#melee_creep.team_comp.team = 0
				#elif point.is_in_group("1"):#vermelho
					#melee_creep.enemy_core = blue_core
					#melee_creep.team_comp.team = 1
				#creep_box.add_child(melee_creep)
				#melee_creep.global_position = point.global_position

func create_creep(team:int, type:String) -> Creep:
	var creep:Creep
	if type == "melee_creep":
		creep = melee_creep_scene.instantiate()
	#elif type == "ranged_creep": TODO
	creep.team_comp.team = team
	match team:
		0: creep.enemy_core = red_core
		1: creep.enemy_core = blue_core
	return creep
