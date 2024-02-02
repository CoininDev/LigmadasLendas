extends Node3D

@export var atk:Attack
@export var apply_to:Array = ["hitbox_owner"]
@export var radius:float = 0.5
@export var distance:float = 2
@export var speed:float = 10
@export var collide:bool = false
@export var gfx:Material

var obsolete:Array = []
var running = false
@onready var end = $end
@onready var bullet = $bullet

func _ready():
	if gfx:
		$bullet/MeshInstance3D.mesh.material = gfx
	$bullet/CollisionShape3D.shape.radius = radius
	$bullet/MeshInstance3D.mesh.radius = radius
	$bullet/MeshInstance3D.mesh.height = radius*2
	$end.position.z = -distance
	start()
func _process(delta):
	if running:
		run(delta)

func start():
	running = true

func run(delta):
	$bullet.translate(Vector3(0,0,-1) * speed * delta)
	position.y = 0



func _on_bullet_body_entered(body):
	if body != atk.caster:
		for group in apply_to:
			if body.is_in_group(group):
				if !obsolete.has(body):
					body.damage(atk)
					obsolete.append(body)
					if collide:
						queue_free()


func _on_bullet_area_entered(area):
	if area == end:
		queue_free()
