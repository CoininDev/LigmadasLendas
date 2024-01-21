class_name ProjectileTarget
extends Target

var running = false

@export var children = {
	"bullet":Area3D.new(),
	"bullet_graph":MeshInstance3D.new(),
	"bullet_col":CollisionShape3D.new(),
	"end":StaticBody3D.new(),
	"end_col":CollisionShape3D.new(),
	"show_range":MeshInstance3D.new()
}
@export var properties = {
	"distance": 15,
	"gfx": Mesh.new(),
	"radius": 0.5,
	"speed": 10
}

func create():
	children["end"].position.z = -properties["distance"]
	children["end_col"].shape = BoxShape3D.new()
	children["end_col"].disabled = true
	
	children["bullet_col"].position.z = -1
	children["bullet_col"].shape = SphereShape3D.new()
	children["bullet_col"].shape.radius = properties["radius"]
	#properties["graph"].material = load("res://graphics/gold.tres")
	
	children["show_range"].mesh = QuadMesh.new()
	children["show_range"].mesh.material = load("res://graphics/casd.tres")
	children["show_range"].rotation.x = deg_to_rad(-90)
	children["show_range"].position.z = floor(-properties["distance"]/2)
	children["show_range"].mesh.size.y = properties["distance"]
	
	for child in children:
		children[child].name = child
	add_child(children["bullet"])
	children["bullet"].add_child(children["bullet_graph"])
	children["bullet"].add_child(children["bullet_col"])
	add_child(children["end"])
	children["end"].add_child(children["end_col"])
	add_child(children["show_range"])

func _ready():
	create()
	preview()
	children["bullet"].body_entered.connect(check)

func _process(delta):
	if not running:
		preview()
	else:
		run(delta)

func preview():
	if mouse_pos():
		look_at(Vector3(mouse_pos().x,1,mouse_pos().z))
	position.x = caster.position.x
	position.z = caster.position.z
	position.y = 1

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

func check(thing):
	if thing == children["end"]:
		queue_free()
	for group in apply_to:
		if thing.is_in_group(group):
			for effect in effects:
				thing.effects[effect] = effects[effect]

func run(delta):
	children["bullet"].translate(Vector3(0,0,-1) * properties["speed"] * delta)
	position.y = 1

func _input(_event):
	if Input.is_action_just_released(button):
		running = true
		if properties["gfx"] != Mesh.new():
			children["bullet_graph"].mesh = properties["gfx"]
		children["show_range"].visible = false
