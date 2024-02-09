extends Node3D
@export var atk:Attack
@export var apply_to:Array = ["hitbox_owner"]
@export var thickness:float = 2
@export var length:float = 5
@export var delay:float = 1
@onready var area = $Area3D
var running:bool=false

func _ready():
	$Area3D/CollisionShape3D.shape.x = thickness
	$Area3D/MeshInstance3D.mesh.x = thickness
	$Area3D/CollisionShape3D.shape.z = length
	$Area3D/MeshInstance3D.mesh.z = length
	$DelayTimer.start(delay)



func _process(delta):
	if running:
		for body in area.get_overlapping_bodies():
			for x in apply_to:
				if body.is_in_group(x) && !body == atk.caster:
					body.dmgr.damage(atk)
					atk.caster.ultimoAlvo = body


func _on_timer_timeout():
	queue_free()


func _on_delay_timer_timeout():
	running = true
