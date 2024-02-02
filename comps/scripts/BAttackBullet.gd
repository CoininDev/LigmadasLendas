extends Area3D

@export var col:Shape3D
@export var gfx:Mesh
@export var target:Node3D
@export var speed = 0.5
@export var atk:Attack

func _ready():
	$CollisionShape3D.shape = col
	$MeshInstance3D.mesh = gfx

func _process(delta):
	var velocity = global_position.direction_to(target.position) * speed
	global_position += velocity

func _on_body_entered(body):
	if body == target:
		target.damage(atk)
		queue_free()

func cancel():
	queue_free()
