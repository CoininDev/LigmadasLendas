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
				#var raycast_query = PhysicsRayQueryParameters3D.create(creep.global_position, target.global_position, 1)
				#var raycast_result:Dictionary= creep.get_world_3d().direct_space_state.intersect_ray(raycast_query)
				#if raycast_result:
					#if raycast_result["collider"] == target:
						#batk.select_target(target)
						#print("bazinga")
				#break
	
	var has_enemy_target:bool = false
	for target in targets:
		if target.is_in_group(creep.team_comp.enemy_team_str):
			has_enemy_target = true
	if not has_enemy_target:
		transitioned.emit(self, "creepinitialstate")
