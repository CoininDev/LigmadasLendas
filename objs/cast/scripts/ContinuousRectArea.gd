extends Cast
@export var thickness:float = 2
@export var length:float = 5
@export var delay:float = 1
@export var time:float = 1
@onready var area = $Area3D
var running:bool=false

func _ready():
	$Area3D/CollisionShape3D.shape.size.x = thickness
	$Area3D/MeshInstance3D.mesh.size.x = thickness
	$Area3D/CollisionShape3D.shape.size.z = length
	$Area3D/MeshInstance3D.mesh.size.z = length
	$DelayTimer.start(delay)

func _process(delta):
	$Area3D/CollisionShape3D.shape.size.x = thickness
	$Area3D/MeshInstance3D.mesh.size.x = thickness
	$Area3D/CollisionShape3D.shape.size.z = length
	$Area3D/MeshInstance3D.mesh.size.z = length
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
