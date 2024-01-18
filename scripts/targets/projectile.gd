extends Node3D

@export var caster : Node3D
@export var effects : Dictionary
@export var apply_to : Array
@export var speed = 10
var running = false
func _process(delta):
	if not running:
		look_at(Vector3(mouse_pos().x,1,mouse_pos().z))
		position.x = caster.position.x
		position.z = caster.position.z
	if running:
		run(delta)
func mouse_pos():
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
		return result.position
func _input(event):
	if Input.is_action_just_pressed("mleft"):
		running = true
func run(delta):
	$bullet.translate(Vector3(0,0,-1) * speed * delta)
	position.y = 1

func _on_bullet_area_entered(body):
	if body.name == "end":
		queue_free()
	for group in apply_to:
		if body.is_in_group(group):
			for effect in effects:
				body.effects[effect] = effects[effect]
