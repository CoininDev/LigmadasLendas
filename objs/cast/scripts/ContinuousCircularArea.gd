extends Cast

@export var radius:float = 2
@export var delay:float = 1
@export var time:float = 1
@onready var area = $Area3D
var running:bool=false

func _ready():
	$Area3D/CollisionShape3D.shape.radius = radius
	$Area3D/MeshInstance3D.mesh.radius = radius
	$Area3D/MeshInstance3D.mesh.height = radius
	$DelayTimer.start(delay)



func _process(delta):
	if running:
		for body in area.get_overlapping_bodies():
			for x in apply_to:
				if body.is_in_group(x) && !body == atk.caster:
					body.dmgr.damage(atk)
					atk.caster.ultimoAlvo = body


func _on_timer_timeout():
	remove_self()


func _on_delay_timer_timeout():
	running = true
	if time > 0:
		$Timer.start(time)
