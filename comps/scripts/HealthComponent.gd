extends Node3D
class_name HealthComponent

signal died
signal damaged

@export var MAX_HEALTH:float = 100
@export var physical_resistance:float = 0
@export var magical_resistance:float = 0
var health:float

func _ready():
	health = MAX_HEALTH

func damage(atk: Attack):
	print(atk.physic_damage)
	atk.physic_damage -= atk.physic_damage * physical_resistance
	atk.magic_damage -= atk.physic_damage * magical_resistance
	print(atk.physic_damage)
	
	health -= atk.physic_damage
	health -= atk.magic_damage
	damaged.emit()
	
	if health <= 0:
		if atk.caster.has_method("cancel"):
			died.connect(atk.caster.cancel)
		died.emit()
		get_parent().queue_free()

func damage_continuous(atk: Attack):
	atk.physic_continuous_damage -= physical_resistance
	atk.magic_continuous_damage -= magical_resistance
	
	health -= atk.physic_continuous_damage
	health -= atk.magic_continuous_damage
	damaged.emit()
	
	if health <= 0:
		if atk.caster.has_method("cancel"):
			died.connect(atk.caster.cancel)
		died.emit()
		get_parent().queue_free()

func heal(healing:float):
	if health < MAX_HEALTH:
		health += healing
