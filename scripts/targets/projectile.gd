extends Node3D

@export var caster:Node3D
@export var effects:Dictionary
@export var apply_to:Array
@export var button:String

@export var properties:Dictionary

var running = false

func _ready():
	positioning_phase()
	$bullet/CollisionShape3D.shape.radius = properties["radius"]
	$end.position.z = -properties["distance"]
	$RangeShow.position.z = floor(-properties["distance"]/2)
	$RangeShow.mesh.size.y = properties["distance"]
func _process(delta):
	if not running:
		positioning_phase()
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
func _input(_event):
	if Input.is_action_just_released(button):
		running = true
		if properties["graphics"]:
			$bullet/MeshInstance3D.mesh = properties["graphics"]
		$RangeShow.visible = false
func run(delta):
	$bullet.translate(Vector3(0,0,-1) * properties["speed"] * delta)
	position.y = 1

func _on_bullet_area_entered(body):
	if body.name == "end":
		queue_free()
	for group in apply_to:
		if body.is_in_group(group):
			for effect in effects:
				body.effects[effect] = effects[effect]


func positioning_phase():
	look_at(Vector3(mouse_pos().x,1,mouse_pos().z))
	position.x = caster.position.x
	position.z = caster.position.z
	position.y = 1
