extends Node3D
@export var hitbox: HitboxComponent

func damage(atk: Attack):
	hitbox.damage(atk)
