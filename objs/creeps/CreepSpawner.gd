extends Node
class_name CreepSpawner
@export var time:float = 30
@export var blue_core:Core
@export var red_core:Core
@export var creep_box:Node
@export var ability_box:Node
var time_countdown:float
var melee_creep_scene:PackedScene = load("res://objs/creeps/melee_creep.tscn")
var ranged_creep_scene:PackedScene = load("res://objs/creeps/ranged_creep.tscn")

func _ready():
	time_countdown = time 

func _process(delta):
	time_countdown -= delta
	if time_countdown <= 0:
		GeneralFuncs.creep_count += 36
		for team_node in get_children():
			var valid_teams:Dictionary = {"blue":0, "red":1}
			if valid_teams.has(team_node.name.to_lower()):
				for lane_node in team_node.get_children():
					var valid_lanes:Dictionary = {"top":2, "mid":3, "bot":4}
					if valid_lanes.has(lane_node.name.to_lower()):
						for point in lane_node.get_children():
							var creep:Creep = create_minion_creep(valid_teams[team_node.name.to_lower()], point.get_groups()[0], valid_lanes[lane_node.name.to_lower()])
							#lane é um seletor de navigation layer, 1= geral, para players; 2 = toplane; 3 = midlane; 4 = botlane
							creep_box.add_child(creep)
							creep.global_position = point.global_position
		time_countdown = time 

func create_minion_creep(team:int, type:String, lane:int) -> MinionCreep:
	var creep:MinionCreep
	if type == "melee_creep":
		creep = melee_creep_scene.instantiate()
	elif type == "ranged_creep":
		creep = ranged_creep_scene.instantiate()
	creep.team_comp.team = team
	creep.lane = lane
	creep.ability_box = ability_box
	match team:
		0: creep.enemy_core = red_core
		1: creep.enemy_core = blue_core
	return creep

func free_all_creeps():
	for creep in creep_box.get_children(): 
		creep.queue_free()
