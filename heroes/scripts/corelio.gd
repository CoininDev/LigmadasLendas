extends HeroBase

@export var health_Comp:HealthComponent

var q_dano = 10
var w_dano = 0
var e_dano = 0

var q_tempo = 10

#marcaçoes disponiveis
var marcado1:Node
var marcado2:Node
var marcado3:Node
var marcado4:Node
var marcado5:Node

#verificação de vida para a divida
var ultimavida = 0
var vida_contagem = 0

func _ready():
	ultimavida = health_Comp.health
	print(ultimavida)
	_ready_base()
	q.atk = Attack.new()
	w.atk = Attack.new()
	e.atk = Attack.new()
	q.range = 10
	w.range = 15
	e.range = 15
	q.atk.caster = self
	w.atk.caster = self
	e.atk.caster = self

func _process(delta):
	verificar_dividas()
	
	#caso receba dano aumenta a divida de quem esta marcado
	if health_Comp.health < ultimavida:
		endividar((ultimavida - health_Comp.health) * 30/100)
		print((ultimavida - health_Comp.health) * 30/100)
		ultimavida = health_Comp.health
	
	q.atk.physic_damage = q_dano 
	q.target_direction = q_p.global_rotation
	q.atk.devendo_time = q_tempo
	
	w.atk.physic_damage = w_dano 
	
	e.atk.physic_damage = e_dano 
	e.target_direction = e_p.global_rotation

func q_preview():
	q_p.mesh_instance.position.z = -q.range / 2
	q_p.mesh_instance.scale.z = q.range
	q_p.visible = true

func q_cast():
	var t = load("res://objs/cast/moeda_corelio.tscn").instantiate()
	t.atk = q.atk
	t.distance = q.range
	t.speed = 30
	t.collide = true
	ability_box.add_child(t)
	t.global_rotation = q.target_direction
	t.global_position = global_position
	q_p.visible = false

func marcar(pessoa):
	print(pessoa)
	if pessoa != null && pessoa != marcado1 && pessoa != marcado2 && pessoa != marcado3 && pessoa != marcado4 && pessoa != marcado5:
		if  marcado1 == null:
			marcado1 = pessoa
			print("m1")
			
		elif marcado2 == null:
			marcado2 = pessoa
			print("m2")
			
		elif marcado3 == null:
			marcado3 = pessoa
			print("m3")
			
		elif marcado4 == null:
			marcado4 = pessoa
			print("m4")
			
		elif marcado5 == null:
			marcado5 = pessoa
			print("m5")

func endividar(quanto:float):
	if marcado1 != null:
		marcado1.divida += quanto
		print("divida m1")
	if marcado2 != null:
		marcado2.divida += quanto
		print("divida m2")
	if marcado3 != null:
		marcado3.divida += quanto
		print("divida m3")
	if marcado4 != null:
		marcado4.divida += quanto
		print("divida m4")
	if marcado5 != null:
		marcado5.divida += quanto
		print("divida m5")

func verificar_dividas():
	if  marcado1 != null && marcado1.devendo_efeito == false:
		marcado1 = null
		print("m1 acabou o efeito")
		
	if  marcado2 != null && marcado2.devendo_efeito == false:
		marcado2 = null
		print("m2 acabou o efeito")
		
	if  marcado3 != null && marcado3.devendo_efeito == false:
		marcado3 = null
		print("m3 acabou o efeito")
		
	if  marcado4 != null && marcado4.devendo_efeito == false:
		marcado4 = null
		print("m4 acabou o efeito")
		
	if  marcado5 != null && marcado5.devendo_efeito == false:
		marcado5 = null
		print("m5 acabou o efeito")