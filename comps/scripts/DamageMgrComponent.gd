extends Node
class_name DamageMgrComponent

@export var health_component: HealthComponent
@export var effects_component: EffectsComponent

func damage(atk: Attack):
	if health_component:
		health_component.damage(atk)
	if effects_component:
		effects_component.apply(atk)
