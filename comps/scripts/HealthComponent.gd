extends Node3D
class_name HealthComponent

signal died

@export var MAX_HEALTH:float = 100
@export var health_bar_visible:bool = false
@onready var health_bar = $SubViewport/HealthBar
@onready var damage_bar = $SubViewport/HealthBar/DamageBar
@onready var damage_bar_timer = $SubViewport/HealthBar/DamageBar/Timer
@onready var bar_sprite = $Sprite3D
var health:float

func _ready():
	health = MAX_HEALTH
	health_bar.max_value = MAX_HEALTH
	health_bar.value = health
	damage_bar.max_value = MAX_HEALTH
	damage_bar.value = health
	bar_sprite.visible = health_bar_visible

func _process(delta):
	health_bar.value = health

func damage(atk: Attack):
	health -= atk.atk_damage
	damage_bar_timer.start()
	
	if health <= 0:
		died.connect(atk.caster.cancel)
		died.emit()
		get_parent().queue_free()



func _on_timer_timeout():
	damage_bar.value = health
