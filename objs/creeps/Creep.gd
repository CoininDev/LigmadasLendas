extends CharacterBody3D
class_name Creep

@export var dmgr:DamageMgrComponent
@export var team_comp:TeamComponent


func die():
	GeneralFuncs.creep_count -=1
	queue_free()
