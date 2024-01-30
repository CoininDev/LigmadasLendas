extends Node3D
class_name SanityComponent

@export var MAX_SANITY:float = 100
@export var health_comp:HealthComponent
@onready var timer:Timer = $Timer
var sanity:float = 0 

func _ready():
	sanity = MAX_SANITY

func _on_timer_timeout():
	var heal = sanity/100 * 0.05
	health_comp.heal(health_comp.MAX_HEALTH*heal)
