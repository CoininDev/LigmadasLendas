extends Node
class_name CreepTargetState

@export var area:Area3D
@export var batk:BAttackComponent
@export var targets:Array

func enter() -> void:
	targets = area.get_overlapping_bodies().slice(1)
	batk.select_target(targets[0])

func update() -> void:
	targets = area.get_overlapping_bodies().slice(1)
	if !targets.is_empty():
		
