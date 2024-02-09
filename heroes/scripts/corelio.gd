extends HeroBase

@export var nav:NavigationComponent
#habilidade Q - variaveis
var q_dano = 100
var q_tempo = 5
#habilidade Q - variaveis
var w_dano = 70
#habilidade Q - variaveis
var e_dano = 60
var e_range = 3
var e_destiny_pos:Vector3

func _ready():
	_ready_base()  
	q.atk = Attack.new()
	w.atk = Attack.new()
	e.atk = Attack.new()
	q.range = 10
	w.range = 2.1
	q.atk.caster = self
	w.atk.caster = self
	e.atk.caster = self

func _process(delta):
	q.atk.physic_damage = q_dano 
	q.atk.dividendo_time = q_tempo
	q.target_direction = q_p.global_rotation
	
	w.atk.physic_damage = w_dano
	w.atk.stun_time = 0.5
	
	e.atk.physic_damage = e_dano
	e.range = e_range
	e.target_direction = e_p.global_rotation
	

func q_preview():
	q_p.mesh_instance.position.z = -q.range / 2
	q_p.mesh_instance.scale.z = q.range
	q_p.visible = true

func q_cast():
	var t = load("res://objs/targets/cast/cena/moeda_corelio.tscn").instantiate()
	t.atk = q.atk
	t.distance = q.range
	t.radius = 0.25
	t.speed = 25
	t.collide = true
	t.global_rotation = q.target_direction
	ability_box.add_child(t)
	t.global_position = global_position
	q_p.visible = false
