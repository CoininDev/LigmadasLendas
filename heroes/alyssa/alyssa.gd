extends HeroBase

#P
var p_dano:float
@export var p_p:Node3D

#Q
var q_rastro:Node3D
var q_projetil:Node3D
var q_dano:float = 40

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
	#p
	p.atk.magic_damage = p_dano + (ability_power * 0.2) + (r_dano_add + (ability_power * 1.2))
	p_p.atk = p.atk
	p_p.apply_to = p.apply_to
	#q
	q.target_direction = q_p.global_rotation
	q.atk.magic_damage = q_dano + (ability_power * 0.75)
	print(q_rastro)
	if q_rastro and q_projetil: 
		q_rastro.area.position.z = -position.distance_to(q_projetil.bullet.position)/2
		q_rastro.length = position.distance_to(q_projetil.bullet.position)

func q_preview():
	q_p.mesh_instance.position.z = -q.range/2
	q_p.mesh_instance.scale.z = q.range
	q_p.visible = true

func q_cast():
	#projetil
	q_projetil = load("res://objs/cast/scenes/projectile.tscn").instantiate()
	q_projetil.speed = 5
	q_projetil.atk = q.atk
	q_projetil.radius = 0.25
	q_projetil.distance = q.range
	ability_box.add_child(q_projetil)
	q_projetil.global_rotation = q.target_direction
	q_projetil.global_position = global_position
	#rastro
	q_rastro = load("res://objs/cast/scenes/continuous_rect_area.tscn").instantiate()
	q_rastro.atk = Attack.new()
	q_rastro.atk.slow_time = 0.5
	q_rastro.atk.caster = self
	ability_box.add_child(q_rastro)
	q_rastro.global_rotation = q.target_direction
	q_rastro.global_position = global_position
	q_p.visible = false
