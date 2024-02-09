extends Node3D
class_name MostrarEfeitoNoPersonagem

@export var fx_comp:EffectsComponent

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if fx_comp.efeito1 == 1:
		$dividendo_sprite.visible = true
	else:
		$dividendo_sprite.visible = false
	
