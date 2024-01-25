extends Area3D
class_name HitboxComponent

@export var health_component: Node3D

# Called when the node enters the scene tree for the first time.
func _ready():
	get_parent().add_to_group("hitbox_owner")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func damage(atk: Attack):
	if health_component:
		health_component.damage(atk)
