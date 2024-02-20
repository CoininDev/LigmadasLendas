extends State
class_name CreepInitialState

@export var creep:Creep
@export var nav:NavigationComponent
var point_to_go:Vector3


func enter():
	point_to_go = creep.enemy_core.global_position
	nav.select_destiny(point_to_go, 3)
