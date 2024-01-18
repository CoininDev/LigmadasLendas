extends Node3D

@export var caster : Node3D
@export var effects : Dictionary
@export var apply_to : Array
@export var range = 20
var inside : Array

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
func _process(delta):
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
		if $area.position.z < -range:
			$area.position.z = -range
func _on_body_entered(body):
	for group in apply_to:
		if body.is_in_group(group) and body != caster:
			inside.append(body)
func _on_body_exited(body):
	if inside.has(body):
		inside.erase(body)
func _input(event):
	if Input.is_action_just_pressed("mleft"):
		for i in inside:
			for effect in effects:
				i.effects[effect] = effects[effect]
