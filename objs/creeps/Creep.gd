extends CharacterBody3D
class_name Creep

@export var dmgr:DamageMgrComponent
@export var team_comp:TeamComponent


func die(_self:Node3D):
	GeneralFuncs.creep_count -=1
	queue_free()
