extends StaticBody3D
class_name Core
@export var team_comp:TeamComponent
@export var dmgr:DamageMgrComponent
#@export var enemy_core:Node3D

var colors:Array = [Color.DARK_BLUE, Color.CYAN]
var melee_creep_scene:PackedScene = preload("res://objs/creeps/melee_creep.tscn")

func _ready():
	var new_material = StandardMaterial3D.new()
	new_material.albedo_color = colors[team_comp.team]
	new_material.shading_mode = BaseMaterial3D.SHADING_MODE_UNSHADED
	$MeshInstance3D.mesh.surface_set_material(0,new_material)
	print()

func die():
	queue_free()

#func creep_spawn():
	#for point in $CreepSpawnPoints.get_children():
		#var creep = melee_creep_scene.instantiate()
		#creep.enemy_core = enemy_core
		#creep.team_comp.team = team_comp.team
		#add_child(creep)
		#creep.global_position = point.global_position
