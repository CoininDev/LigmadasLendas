extends Node3D

@export var atk:Attack
@export var dinheiro:float
@export var apply_to:Array = ["hitbox_owner"]
@export var radius:float = 2
@export var delay:float = 10
@onready var area = $Area3D

func _ready():
	$Timer.start(delay)


func _on_timer_timeout():
	queue_free()

func _on_area_3d_body_entered(body):
	queue_free()
