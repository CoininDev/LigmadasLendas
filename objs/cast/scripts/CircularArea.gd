extends Cast

@export var radius:float = 2
@export var delay:float = 1
@export var explosion_particles_gfx:Mesh
@export var explosion_particles_amount:float = 20
@onready var area = $Area3D

func _ready():
	$Area3D/CollisionShape3D.shape.radius = radius
	if gfx:
		$Area3D/MeshInstance3D.mesh = gfx
	if $Area3D/MeshInstance3D.mesh is SphereMesh:
		$Area3D/MeshInstance3D.mesh.radius = radius
		$Area3D/MeshInstance3D.mesh.height = radius
	if explosion_particles_gfx:
		$Area3D/GPUParticles3D.draw_pass_1 = explosion_particles_gfx
		$Area3D/GPUParticles3D.amount = explosion_particles_amount
	$Timer.start(delay)


func _on_timer_timeout():
	attack()

func attack():
	for body in area.get_overlapping_bodies():
		for x in apply_to:
			if body.is_in_group(x) && !body == atk.caster:
				body.dmgr.damage(atk)
				atk.caster.ultimoAlvo = body
	$Area3D/MeshInstance3D.visible = false
	$Area3D/GPUParticles3D.emitting = true
	$EffectTimer.start(2)


func _on_effect_timer_timeout():
	remove_self()
	queue_free()
