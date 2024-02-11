extends Node3D

@export var atk:Attack
@export var dinheiro:float
@export var apply_to:Array = ["hitbox_owner"]
@export var radius:float = 2
@export var delay:float = 10
@onready var area = $Area3D
@export var dmgr:DamageMgrComponent


var type = "ward"
func _ready():
	$Timer.start(delay)


func _on_timer_timeout():
	queue_free()

func die():
	var t = load("res://objs/cast/scenes/circular_area.tscn").instantiate()
	t.atk = atk
	t.delay = 0.1
	t.radius = radius
	atk.caster.ability_box.add_child(t)
	t.global_position = self.global_position
	$GPUParticles3D.emitting = true
	$GPUParticles3D2.emitting = true
	
	var s = load("res://heroes/corelio/material/chuva_de_dinheiro.tscn").instantiate()
	atk.caster.ability_box.add_child(s)
	s.global_position = global_position
	s.emitting = true
	
	$CollisionShape3D.queue_free()
	$MeshInstance3D.queue_free()
	$finaltimer.start()


func _on_finaltimer_timeout():
	queue_free()
