extends Node3D

@export var gold:float
@export var apply_to:Array = ["0"]
@export var radius:float = 2
@export var delay:float = 10
@onready var area = $Area3D

func _ready():
	$Timer.start(delay)


func _on_timer_timeout():
	queue_free()

func _on_area_3d_body_entered(body):
	for x in apply_to:
		if body.is_in_group(x) and body is HeroBase:
			body.gold += self.gold
			queue_free()
