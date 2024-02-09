extends Node3D
class_name ShowEffect

var dividendo = false
@onready var timerpagar = $PagarTimer

func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$divida.visible = dividendo

func pagar():
	$pagar.visible = true
	timerpagar.start(1)


func _on_pagar_timer_timeout():
	$pagar.visible = false
