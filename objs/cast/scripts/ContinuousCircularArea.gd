extends Cast

@export var radius:float = 2
@export var delay:float = 1
@export var pulse:float = 0.5
@export var time:float = 1
@onready var area = $Area3D
var running:bool=false

func _ready():
	$Area3D/MeshInstance3D.mesh = gfx
	$Area3D/CollisionShape3D.shape.radius = radius
	if $Area3D/MeshInstance3D.mesh is SphereMesh:
		$Area3D/MeshInstance3D.mesh.radius = radius
		$Area3D/MeshInstance3D.mesh.height = radius
	$DelayTimer.start(delay)

func _process(delta):
	$Area3D/CollisionShape3D.shape.radius = radius
	$Area3D/MeshInstance3D.mesh.radius = radius
	$Area3D/MeshInstance3D.mesh.height = radius

func _on_timer_timeout():
	remove_self()


func _on_delay_timer_timeout():
	running = true
	$Pulse.start(pulse)     
	if time > 0:
		$Timer.start(time)


func _on_pulse_timeout():
	for body in area.get_overlapping_bodies():
		for x in apply_to:
			if body.is_in_group(x) && !body == atk.caster:
				body.dmgr.damage(atk)
				atk.caster.ultimoAlvo = body
