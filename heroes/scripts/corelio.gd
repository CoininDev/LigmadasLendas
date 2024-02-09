extends HeroBase

@export var health_Comp:HealthComponent
@onready var passiva_timer = $AbilityPointers/PTimer

#Q
var q_tempo = 10
var q_dano = 10

#W
var w_dano = 0

#E
var e_dano = 0

#passiva
var p_distancia_max = 5
var p_tempo = 10




var random = RandomNumberGenerator.new()

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
	passiva_timer.start(p_tempo)
	ultimavida = health_Comp.health
	print(ultimavida)
	_ready_base()
	q.atk = Attack.new()
	w.atk = Attack.new()
	e.atk = Attack.new()
	p.atk = Attack.new()
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
	var t = load("res://objs/cast/scenes/moeda_corelio.tscn").instantiate()
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
			
		elif marcado2 == null:
			marcado2 = pessoa
			
		elif marcado3 == null:
			marcado3 = pessoa
			
		elif marcado4 == null:
			marcado4 = pessoa
			
		elif marcado5 == null:
			marcado5 = pessoa

func endividar(quanto:float):
	if marcado1 != null:
		marcado1.fx_comp.divida += quanto
	if marcado2 != null:
		marcado2.fx_comp.divida += quanto
	if marcado3 != null:
		marcado3.fx_comp.divida += quanto
	if marcado4 != null:
		marcado4.fx_comp.divida += quanto
	if marcado5 != null:
		marcado5.fx_comp.divida += quanto

func verificar_dividas():
	if  marcado1 != null && marcado1.fx_comp.devendo_efeito == false:
		marcado1 = null
		
	if  marcado2 != null && marcado2.fx_comp.devendo_efeito == false:
		marcado2 = null
		
	if  marcado3 != null && marcado3.fx_comp.devendo_efeito == false:
		marcado3 = null
		
	if  marcado4 != null && marcado4.fx_comp.devendo_efeito == false:
		marcado4 = null
		print("m4 acabou o efeito")
		
	if  marcado5 != null && marcado5.fx_comp.devendo_efeito == false:
		marcado5 = null


func _on_p_timer_timeout():
	passiva_timer.start(p_tempo)
	var t = load("res://objs/cast/scenes/dinheiro_corelio.tscn").instantiate()
	t.atk = p.atk
	t.dinheiro = 20
	ability_box.add_child(t)
	t.global_position.x = self.global_position.x + random.randf_range(-p_distancia_max,p_distancia_max)
	t.global_position.z = self.global_position.z + random.randf_range(-p_distancia_max,p_distancia_max)
	t.global_position.y = 0
