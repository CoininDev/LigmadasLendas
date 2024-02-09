extends Control
@export var camera:Camera3D
@onready var label = $Label
@onready var label2 = $Label2

func _input(event):
	if !event is InputEventMouseMotion:
		label.text = event.as_text()

func _process(delta):
	label2.text = str(-camera.position.z)
