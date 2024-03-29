extends Node3D

@export var atk:Attack
@export var radius:float = 0.5
@export var distance:float = 2
@export var speed:float = 5
@export var collide:bool = false
@export var gfx:Material



var obsolete:Array = []
var running = false
@onready var end = $end
@onready var bullet = $bullet
var rng = RandomNumberGenerator.new()
var girar = 0

func _ready():
	girar = rng.randf_range(-5, 5)
	girar = girar/10
	if gfx:
		$bullet/MeshInstance3D.mesh.material = gfx
	$end.position.z = -distance
	start()
	
func _process(delta):
	if $bullet:
		$bullet/MeshInstance3D.rotation.x += girar
		if running:
			run(delta)

func start():
	running = true

func run(delta):
	$bullet.translate(Vector3(0,0,-1) * (speed/5) * delta)
	position.y = 0.5 



func _on_bullet_body_entered(body):
	if body != atk.caster:
		for group in atk.apply_to:
			if body.is_in_group(group):
				if !obsolete.has(body):
					body.dmgr.damage(atk) 
					atk.caster.marcar(body)
					obsolete.append(body)
					if collide:
						$end/GPUParticles3D.emitting = true
						$end.position = $bullet.position
						$bullet.queue_free()
						$finalTimer.start()


func _on_bullet_area_entered(area):
	if area == end:
		$end/GPUParticles3D.emitting = true
		$bullet.queue_free()
		$finalTimer.start()


func _on_final_timer_timeout():
	queue_free()
