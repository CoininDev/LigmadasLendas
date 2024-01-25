extends Node3D
class_name HealthComponent

#signal died

@export var MAX_HEALTH:float = 100
@export var health_bar_visible:bool = false
@onready var health_bar = $SubViewport/HealthBar
@onready var damage_bar = $SubViewport/HealthBar/DamageBar
@onready var damage_bar_timer = $SubViewport/HealthBar/DamageBar/Timer
var health:float

func _ready():
	health = MAX_HEALTH
	health_bar.visible = health_bar_visible
	health_bar.max_value = MAX_HEALTH
	health_bar.value = health
	damage_bar.visible = health_bar_visible
	damage_bar.max_value = MAX_HEALTH
	damage_bar.value = health

func _process(delta):
	health_bar.value = health
	if health_bar_visible:
		#print(health)
		pass

func damage(atk: Attack):
	health -= atk.atk_damage
	damage_bar_timer.start()
	
	if health <= 0:
		#died.emit()
		get_parent().queue_free()


func _on_timer_timeout():
	damage_bar.value = health
