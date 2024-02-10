extends HeroBase

#Q parcelado: o coelho joga uma moeda, se acertar um campeão inimigo ele recebe 10/25/50/65/100 (+ 120% do dano magico) de dano magico, ele fica marcado como dividendo por 10s/20s/25s/30s/40s, caso o coelho receba dano dentro desse tempo, o campeão acumula 30% do dano causado em sua divida.  apos o efeito acabar ou o coelho morrer o campeão recebe o efeito de pagando divida recebendo dano continuo até acabar todo o dano acumulado na divida.
#
#W cofre: o coelho coloca um cofre no chão e quando acertado com um auto ataque ou com uma habilidade o cofre explode espalhando notas de dinheiro pelo chao a uma distancia de até 40, e causando uma explosão no raio de 10, causando 100/150/200/250/300 (+ 75% do dano magico) de dano magico.
#
#E cobrança: caso um campeão inimigo estiver marcado como dividendo estiver em uma area de 50 do coelho e estiver visivel, o coelho cobra o total do da divida mais juros de 10%/20%/40%/80%/100% (+ 20% de dano magico) da divida do inimigo sua divida de uma vez como dano magico.
#
#R o verdadeiro poder da riqueza: o campeão absorve a aura e expele ela para a frente, causando 200% do dano magico. o campeão fica atordoado por 0.5s e fica sem sua aura por 60s/40s/20s não podendo utilizar suas habilidades.

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
		endividar((ultimavida - health_Comp.health) * 0.3)
		print((ultimavida - health_Comp.health) * 0.3)
		ultimavida = health_Comp.health
	
	#propriedades do Q
	q.atk.physic_damage = q_dano + (q_dano * (ability_power * 0.3)) + (q_dano * buff)
	q.target_direction = q_p.global_rotation
	q.atk.devendo_time = q_tempo
	
	#propriedades do W
	w.atk.physic_damage = w_dano 
	
	#propriedades do E
	e.atk.physic_damage = e_dano 
	e.target_direction = e_p.global_rotation

func q_preview():
	q_p.mesh_instance.position.z = -q.range / 2
	q_p.mesh_instance.scale.z = q.range
	q_p.visible = true

func q_cast():
	var t = load("res://heroes/corelio/casts/moeda_corelio.tscn").instantiate()
	t.atk = q.atk
	t.distance = q.range
	t.speed = 30
	t.collide = true
	ability_box.add_child(t)
	t.global_rotation = q.target_direction
	t.global_position = global_position
	q_p.visible = false

func w_preview():
	w_p.mesh_instance.mesh = load("res://graphics/3d models/cofre.obj")
	w_p.mesh_instance.get_mesh().surface_set_material(0,load("res://graphics/materials/visualizar.tres"))
	w_p.mesh_instance.rotation_degrees.y = -90
	w_p.mesh_instance.scale = Vector3(0.5, 0.5, 0.5)
	w_p.visible = true

func w_cast():
	pass

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
	else:
		pessoa.fx_comp.divida += 50

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
		
	if  marcado5 != null && marcado5.fx_comp.devendo_efeito == false:
		marcado5 = null


func _on_p_timer_timeout():
	passiva_timer.start(p_tempo)
	var t = load("res://heroes/corelio/casts/dinheiro_corelio.tscn").instantiate()
	t.atk = p.atk
	t.dinheiro = 20
	ability_box.add_child(t)
	t.global_position.x = self.global_position.x + random.randf_range(-p_distancia_max,p_distancia_max)
	t.global_position.z = self.global_position.z + random.randf_range(-p_distancia_max,p_distancia_max)
	t.global_position.y = 0
