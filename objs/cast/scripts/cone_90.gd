extends Cast

@export var radius:float = 0.5
@export var distance:float = 2
@export var speed:float = 10
@export var collide:bool = false

var obsolete:Array = []
var running = false
@onready var end = $end
@onready var bullet = $bullet

func _ready():
	if gfx:
		$bullet/MeshInstance3D.mesh.material = gfx
	#$bullet/CollisionShape3D.shape.radius = radius
	#$bullet/MeshInstance3D.mesh.radius = radius
	#$bullet/MeshInstance3D.mesh.height = radius*2
	$end.position.z = -distance
	$end.position.z += 0.5
	start()
func _process(delta):
	if running:
		run(delta)

func start():
	running = true

func run(delta):
	$bullet.scale.x += 0.15 * (speed/10)
	$bullet.scale.z += 0.1 * (speed/10)
	$bullet.translate(Vector3(0,0,-1) * (speed/10) * delta)
	position.y = 0.5



func _on_bullet_body_entered(body):
	if body != atk.caster:
		for group in atk.apply_to:
			if body.is_in_group(group):
				if !obsolete.has(body):
					body.dmgr.damage(atk)
					atk.caster.ultimoAtaque = body
					obsolete.append(body)
					if collide:
						remove_self()


func _on_bullet_area_entered(area):
	if area == end:
		remove_self()
