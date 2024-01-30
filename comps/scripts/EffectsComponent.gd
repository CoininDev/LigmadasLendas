extends Node3D
class_name EffectsComponent

#atordoo, silencio:BAttack;Hero, raiz:Nav, dano continuo:Health, reduç. sanidade:Sanity
@export var battack_comp:BAttackComponent
@export var nav_comp:NavigationComponent
@export var health_comp:HealthComponent
@export var sanity_comp:SanityComponent

@onready var stun_timer = $StunTimer
@onready var root_timer = $RootTimer
@onready var silence_timer = $SilenceTimer
@onready var fear_timer = $FearTimer

func apply(atk:Attack):
	if atk.stun_time > 0:
		stun_timer.start(atk.stun_time)
		nav_comp.blocked = true
		battack_comp.cancel()
		battack_comp.blocked = true

	if atk.root_time > 0:
		root_timer.start(atk.root_time)
		nav_comp.blocked = true

	if atk.silence_time > 0:
		silence_timer.start(atk.silence_time)
		battack_comp.cancel()
		battack_comp.blocked = true

	if atk.fear_time > 0:
		fear_timer.start(atk.fear_time)
		nav_comp.select_destiny(atk.caster.position, nav_comp.desired_distance)
		#print("cu")


func _on_stun_timer_timeout():
	nav_comp.blocked = false
	battack_comp.blocked = false

func _on_root_timer_timeout():
	nav_comp.blocked = false

func _on_silence_timer_timeout():
	battack_comp.blocked = false

func _on_fear_timer_timeout():
	nav_comp.ditch_destiny()
