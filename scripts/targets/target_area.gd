extends Node3D

@export var caster:Node3D
@export var effects:Dictionary
@export var apply_to:Array
@export var button:String

@export var properties:Dictionary

var inside:Array
var running = false

func _ready():
	move()
	position = caster.position
	
	$area/CollisionShape3D.shape.radius = properties["area_radius"]
	$area/MeshInstance3D.mesh.radius = properties["area_radius"]
	$area/MeshInstance3D.mesh.height = properties["area_radius"]
func _process(delta):
	if not running:
		move()
		position = caster.position

func move():
	var camera = get_tree().get_nodes_in_group("camera")[0]
	var mousepos = get_viewport().get_mouse_position()
	var raylen = 1000
	var from = camera.project_ray_origin(mousepos)
	var to = from + camera.project_ray_normal(mousepos) * raylen
	var space = get_world_3d().direct_space_state
	var rayquery = PhysicsRayQueryParameters3D.new()
	rayquery.from = from
	rayquery.to = to
	var result = space.intersect_ray(rayquery)
	if result.has("position"):
		var result0 = Vector3(result.position.x, 0, result.position.z)
		#direction
		look_at(result.position)
		rotation.z = 0
		rotation.x = 0
		
		#distance
		$area.position.z = -result0.distance_to(position)
		if $area.position.z < -properties["range"]:
			$area.position.z = -properties["range"]
func _on_body_entered(body):
	for group in apply_to:
		if body.is_in_group(group) and body != caster:
			inside.append(body)
func _on_body_exited(body):
	if inside.has(body):
		inside.erase(body)
func _input(event):
	if Input.is_action_just_released(button):
		if properties["delay_sec"] > 0:
			running = true
			$area/MeshInstance3D.mesh = properties["graphics"]
			$timer.wait_time = properties["delay_sec"]
			$timer.start()
		else:
			for i in inside:
				for effect in effects:
					i.effects[effect] = effects[effect]
			queue_free()


func _on_timer_timeout():
	for i in inside:
		for effect in effects:
			i.effects[effect] = effects[effect]
	queue_free()
