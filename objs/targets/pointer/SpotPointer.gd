extends Pointer

@export var radius:float = 2
@export var range:float = 15

var mouse_pos:Vector3 = Vector3.ZERO
var mark_pos:Vector3

func _ready():
	$Marker3D/MeshInstance3D.mesh.size.x = radius *2
	$Marker3D/MeshInstance3D.mesh.size.y = radius *2

func _process(delta):
	mouse_pos_processing()
	positioning()
	mark_pos = $Marker3D.global_position
	

func mouse_pos_processing():
	var camera = get_tree().get_nodes_in_group("camera")[0]
	var mousepos = get_viewport().get_mouse_position()
	var raylen = 1000
	var from = camera.project_ray_origin(mousepos)
	var to = from + camera.project_ray_normal(mousepos) * raylen
	var space = get_parent().get_world_3d().direct_space_state
	var rayquery = PhysicsRayQueryParameters3D.new()
	rayquery.collision_mask = 1
	rayquery.from = from
	rayquery.to = to
	var result = space.intersect_ray(rayquery)
	if !result.is_empty():
		mouse_pos = result.position

func positioning():
	look_at(mouse_pos)
	rotation.x = 0
	$Marker3D.position.z = -mouse_pos.distance_to(global_position)
	if $Marker3D.position.z < -range:
		$Marker3D.position.z = -range
