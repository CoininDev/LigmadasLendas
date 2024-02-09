extends Node
class_name DamageMgrComponent

@export var health_component: HealthComponent
@export var effects_component: EffectsComponent


# Called when the node enters the scene tree for the first time.
func _ready():
	get_parent().add_to_group("hitbox_owner")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func damage(atk: Attack):
	if health_component:
		health_component.damage(atk)
	if effects_component:
		effects_component.apply(atk)
