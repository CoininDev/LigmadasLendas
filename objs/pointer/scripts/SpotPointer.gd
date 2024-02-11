extends Pointer

@export var radius:float = 2
@export var range:float = 15
@onready var rangeshow = $Marker3D/RangeShow

var mouse_pos:Vector3 = Vector3.ZERO
var mark_pos:Vector3

func _ready():
	$Marker3D/RangeShow.mesh.size.x = radius *2
	$Marker3D/RangeShow.mesh.size.y = radius *2

func _process(delta):
	mouse_pos_processing()
	positioning()
	mark_pos = $Marker3D.global_position
	#$Marker3D.global_rotation = Vector3(0,0,0)

func mouse_pos_processing():
	var result = GeneralFuncs.mouse_raycast()
	if result:
		mouse_pos = result.position

func positioning():
	look_at(mouse_pos)
	rotation.x = 0
	$Marker3D.position.z = -mouse_pos.distance_to(global_position)
	if $Marker3D.position.z < -range:
		$Marker3D.position.z = -range
