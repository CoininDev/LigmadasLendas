extends HeroBase

#P
var p_dano:float
@export var p_p:Node3D

#Q
var q_dano:float

#W
var w_dano_add:float #quando o W e ativado 
var w_dano_add2:float #quando ela ataca um viciado com o W ativado

#R
var r_dano_add:float #dano adicional na passiva
var r_distancia:float

func _ready():
	_ready_base()
	p.atk = Attack.new()
	p.apply_to = ["viciado"]
	p.atk.caster = self
	
	q.atk = Attack.new()
	q.atk.caster = self
	q.range = 5
	
	w.atk = Attack.new()
	w.atk.caster = self
	
	e.atk = Attack.new()
	e.atk.caster = self

func _process(delta):
	p.atk.magic_damage = p_dano + (ability_power * 0.2) + (r_dano_add + (ability_power * 1.2))
	q.target_direction = q_p.global_rotation
	q.atk.magic_damage = q_dano + (ability_power * 0.75)
	p_p.atk = p.atk
	p_p.apply_to = p.apply_to

func q_preview():
	q_p.mesh_instance.position.z = -q.range/2
	q_p.mesh_instance.scale.z = q.range
	q_p.visible = true

func q_cast():
	#projetil
	var projetil = load("res://objs/cast/scenes/projectile.tscn").instantiate()
	projetil.speed = 5
	ability_box.add_child(projetil)
	projetil.global_rotation = q.target_direction
	projetil.global_position = global_position
	#rastro
	#var rastro = load("res://objs/cast/scenes/continuous_rect_area.tscn").instantiate()
	#ability_box.add_child(rastro)
	#rastro.global_rotation = q.target_direction
	#rastro.global_position = global_position
	#rastro.area.position.z = -q.range/2
