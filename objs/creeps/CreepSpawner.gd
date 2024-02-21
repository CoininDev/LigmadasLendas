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
		for point in get_children():
			if point.is_in_group("melee_creep"):
				var melee_creep = melee_creep_scene.instantiate()
				if point.is_in_group("0"):#azul
					melee_creep.enemy_core = red_core
				elif point.is_in_group("1"):#vermelho
					melee_creep.enemy_core = blue_core
				creep_box.add_child(melee_creep)
				melee_creep.global_position = point.global_position
