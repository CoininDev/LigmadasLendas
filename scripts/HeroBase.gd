extends Node3D
class_name HeroBase
@export var dmgr: DamageMgrComponent
@export var q_p: Node3D
@export var w_p: Node3D
@export var e_p: Node3D
@export var r_p: Node3D

var q = Ability.new()
var w = Ability.new()
var e = Ability.new()
var r = Ability.new()



func damage(atk: Attack):
	dmgr.damage(atk)

func _ready():
	pass

func _process(delta):
	q.target_direction = q_p.position

func q_preview():
	q_p.mesh_instance.position.z = -15/2
	q_p.mesh_instance.scale.z = 15
	q_p.visible = true

func w_preview():
	pass

func e_preview():
	pass

func r_preview():
	r_p.mesh_instance.position.z = -30/2
	r_p.mesh_instance.scale.z = 30
	r_p.visible = true
	

func a_preview():
	pass



func q_cast():
	var atk = Attack.new()
	atk.magic_damage = 30
	var target = load("res://objs/targets/cast/projectile.tscn")
	var target_i = target.instantiate()
	target_i.global_rotation = q_p.global_rotation
	atk.caster = self
	target_i.atk = atk
	target_i.radius = 0.5
	target_i.distance = 15
	target_i.speed = 10
	q_p.visible = false
	get_parent().add_child(target_i)
	target_i.global_position = global_position
func w_cast():
	pass

func e_cast():
	pass

func r_cast():
	var atk = Attack.new()
	atk.magic_damage = 30
	atk.physic_damage = 30
	atk.fear_time = 1 
	atk.caster = self
	var target = load("res://objs/targets/cast/projectile.tscn")
	var ti = target.instantiate()
	ti.global_rotation = r_p.global_rotation
	ti.atk = atk
	ti.radius = 0.5
	ti.speed = 10
	ti.distance = 30
	r_p.visible=false
	get_parent().add_child(ti)
	ti.global_position = global_position

func a_cast():
	pass
