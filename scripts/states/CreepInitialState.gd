extends State
class_name CreepInitialState

@export var creep:Creep
@export var nav:NavigationComponent
@export var area:Area3D
var point_to_go:Vector3


func enter() -> void:
	point_to_go = creep.enemy_core.global_position

func update(_delta:float) -> void:
	nav.select_destiny(point_to_go, 3)
	var targets = area.get_overlapping_bodies().slice(1)
	if !targets.is_empty():
		for target in targets:
			if target.is_in_group(creep.team_comp.enemy_team_str):
				transitioned.emit(self, "creeptargetstate")

func exit() -> void:
	nav.ditch_destiny()

