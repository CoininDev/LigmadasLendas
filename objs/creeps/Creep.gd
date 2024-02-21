extends CharacterBody3D
class_name Creep

@export var dmgr:DamageMgrComponent
@export var team_comp:TeamComponent
@export var enemy_core:Node3D

func die():
	queue_free()
