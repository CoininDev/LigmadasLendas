extends Node3D
class_name BAttackComponent
@export var atk_damage: float
@export var action = "mleft"
@export var range: float
var target: Node3D
#@export var navcomp: NavComponent

#func _input(_event):
	#if Input.is_action_just_pressed(action):
		#for area in get_overlapping_areas():
			#var atk = Attack.new()
			#atk.atk_damage = atk_damage
			#area.damage(atk)
			#print(atk)

func _input(_event):
	select_target()

func select_target():
	if Input.is_action_pressed(action):
		var camera = get_tree().get_nodes_in_group("camera")[0]
		var mousepos = get_viewport().get_mouse_position()
		var raylen = 1000
		var from = camera.project_ray_origin(mousepos)
		var to = from + camera.project_ray_normal(mousepos) * raylen
		var space = get_parent().get_world_3d().direct_space_state
		var rayquery = PhysicsRayQueryParameters3D.new()
		rayquery.from = from
		rayquery.to = to
		var result = space.intersect_ray(rayquery)
		if !result.is_empty():
			target = result.collider
			attack()

func attack():
	print(target.global_position.distance_to(global_position))
	if target.is_in_group("hitbox_owner"):
		if target.global_position.distance_to(global_position) <= range:
			var atk = Attack.new()
			atk.atk_damage = atk_damage
			target.damage(atk)
