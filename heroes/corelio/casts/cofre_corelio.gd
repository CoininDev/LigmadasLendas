extends Node3D

@export var atk:Attack
@export var team_comp:TeamComponent
#@export var dinheiro:float
@export var radius:float = 2
@export var delay:float = 10
@export var dmgr:DamageMgrComponent


var type = "ward"
#func _ready():
	#$Timer.start(delay)


#func _on_timer_timeout():
	#queue_free()

func die():
	var t = load("res://objs/cast/scenes/circular_area.tscn").instantiate()
	t.atk = atk
	t.delay = 0.1
	t.radius = radius
	t.explosion_particles_gfx = load("res://heroes/corelio/material/corelio_dinheiro_mesh.tres")
	t.explosion_particles_amount = 50
	atk.caster.ability_box.add_child(t)
	t.global_position = self.global_position
	$GPUParticles3D.emitting = true
	$GPUParticles3D2.emitting = true
	
	#var s = load("res://heroes/corelio/material/chuva_de_dinheiro.tscn").instantiate()
	#atk.caster.ability_box.add_child(s)
	#s.global_position = global_position
	#s.emitting = true
	
	$CollisionShape3D.queue_free()
	$MeshInstance3D.queue_free()
	$finaltimer.start()


func _on_finaltimer_timeout():
	queue_free()
