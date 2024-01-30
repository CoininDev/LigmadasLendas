extends Node3D

@export var caster:Node3D
@export var atk:Attack
@export var apply_to:Array = ["hitbox_owner"]
@export var radius:float = 0.5
@export var distance:float = 2
@export var graphics:Mesh 
@export var speed:float
@export var unique_victim:bool = false

var running = false
@onready var end = $end
@onready var bullet = $bullet

func _ready():
	print(distance)
	$bullet/CollisionShape3D.shape.radius = radius
	$end.position.z = -distance
	start()
func _process(delta):
	if running:
		run(delta)
	if bullet.has_overlapping_areas():
		print(bullet.get_overlapping_areas())

func start():
	running = true
	if graphics:
		$bullet/MeshInstance3D.mesh = graphics

func run(delta):
	$bullet.translate(Vector3(0,0,-1) * speed * delta)
	position.y = 0



func _on_bullet_body_entered(body):
	if body != atk.caster:
		for group in apply_to:
			if body.is_in_group(group):
				body.damage(atk)


func _on_bullet_area_entered(area):
	if area == end:
		queue_free()
