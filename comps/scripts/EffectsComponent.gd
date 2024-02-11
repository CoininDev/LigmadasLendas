extends Node3D
class_name EffectsComponent
#atordoo, silencio:BAttack;Hero, raiz:Nav, dano continuo:Health, reduç. sanidade:Sanity
@export var battack_comp:BAttackComponent
@export var nav_comp:NavigationComponent
@export var health_comp:HealthComponent
@export var sanity_comp:SanityComponent
@export var hero:HeroBase
var continuous_damage_atk:Attack
var current_effect:String = ""


@onready var stun_timer = $StunTimer
@onready var root_timer = $RootTimer
@onready var silence_timer = $SilenceTimer
@onready var fear_timer = $FearTimer
@onready var continuous_damage_timer = $ContinuousDamageTimer
@onready var continuous_damage_pulse = $ContinuousDamagePulse
@onready var devendo_timer = $DevendoTimer
@onready var reset_efects_timer_1 = $ResetEfects
var caster_divida:HeroBase
var pagar = false
var divida = 0.0
var devendo_efeito = false
#maximo 5
var marks = []
var marktimers = []

func _ready():
	for i in range(5):
		marks.append("")
		marktimers.append(get_node("MarkTimer" + str(i+1)))

func _process(delta):
	if pagar == true:
		current_effect = "pagar"
		print(divida)
		var atk = Attack.new()
		atk.magic_damage = divida
		atk.caster = caster_divida
		health_comp.ignore_resistance_damage(atk)
		devendo_timer.stop()
		reset_efects_timer_1.start()
		divida = 0
		devendo_efeito = false
		pagar = false


	for i in range(5):
		if marktimers[i].is_stopped():
			hero.remove_from_group(marks[i])
			if marks[i] == current_effect:
				current_effect = ""
			marks[i] = ""
		

func apply(atk:Attack):
	
	if atk.devendo_time > 0:
		devendo_timer.start(atk.devendo_time)
		devendo_efeito = true
		current_effect = "devendo"

	if atk.stun_time > 0:
		stun_timer.start(atk.stun_time)
		nav_comp.blocked = true
		battack_comp.cancel()
		battack_comp.blocked = true
		current_effect = "atordoado"

	if atk.root_time > 0:
		root_timer.start(atk.root_time)
		nav_comp.blocked = true

	if atk.silence_time > 0:
		silence_timer.start(atk.silence_time)
		battack_comp.cancel()
		battack_comp.blocked = true
		current_effect = "silenciado"

	if atk.fear_time > 0:
		var direction = position.direction_to(atk.caster.position)
		var distance = 1500
		fear_timer.start(atk.fear_time)
		nav_comp.select_destiny(-direction * distance, nav_comp.desired_distance)
		current_effect = "amedrontado"
	
	if atk.continuous_damage_time > 0:
		continuous_damage_timer.start(atk.continuous_damage_time)
		continuous_damage_pulse.start()
		continuous_damage_atk = atk
	
	if atk.mark_time > 0:
		for i in range(5):
			if marks[i] == "":
				marks[i] = atk.mark
				marktimers[i].start(atk.mark_time)
				current_effect = marks[i]
				hero.add_to_group(marks[i])
				break



func _on_stun_timer_timeout():
	nav_comp.blocked = false
	battack_comp.blocked = false
	current_effect = ""

func _on_root_timer_timeout():
	nav_comp.blocked = false
	current_effect = ""

func _on_silence_timer_timeout():
	battack_comp.blocked = false
	current_effect = ""

func _on_fear_timer_timeout():
	nav_comp.ditch_destiny()
	current_effect = ""

func _on_continuous_damage_timer_timeout():
	continuous_damage_pulse.stop()
	current_effect = ""

func _on_continuous_damage_pulse_timeout():
	health_comp.damage_continuous(continuous_damage_atk)
	current_effect = ""

func _on_devendo_timer_timeout():
	pagar = true
	devendo_efeito = false
	current_effect = ""

func _on_reset_efects_timeout():
	current_effect = " "
