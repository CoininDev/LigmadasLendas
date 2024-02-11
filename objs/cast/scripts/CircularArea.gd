extends Cast

@export var radius:float = 2
@export var delay:float = 1
@onready var area = $Area3D

func _ready():
	$Area3D/CollisionShape3D.shape.radius = radius
	if gfx:
		$Area3D/MeshInstance3D.mesh = gfx
	if $Area3D/MeshInstance3D.mesh is SphereMesh:
		$Area3D/MeshInstance3D.mesh.radius = radius
		$Area3D/MeshInstance3D.mesh.height = radius
	$Timer.start(delay)


func _on_timer_timeout():
	attack()

func attack():
	for body in area.get_overlapping_bodies():
		for x in apply_to:
			if body.is_in_group(x) && !body == atk.caster:
				body.dmgr.damage(atk)
				atk.caster.ultimoAlvo = body
	remove_self()
