extends State
class_name CreepTargetState

@export var area:Area3D
@export var batk:BAttackComponent
@export var creep:Creep
var targets:Array

func update(_delta:float) -> void:
	targets = area.get_overlapping_bodies().slice(1)
	if !targets.is_empty():
		for target in targets:
			if target.is_in_group(creep.team_comp.enemy_team_str):
				batk.select_target(target)
	
	var has_enemy_target:bool = false
	for target in targets:
		if target.is_in_group(creep.team_comp.enemy_team_str):
			has_enemy_target = true
	if not has_enemy_target:
		transitioned.emit(self, "creepinitialstate")
