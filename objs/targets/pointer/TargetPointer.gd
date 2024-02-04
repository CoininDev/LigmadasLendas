extends Pointer

@export var radius:float = 2
@export var range:float = 15

var mouse_pos:Vector3 = Vector3.ZERO
var mark_pos:Vector3

func _ready():
	$Marker3D/MeshInstance3D.mesh.size.x = radius *2
	$Marker3D/MeshInstance3D.mesh.size.y = radius *2

func _process(delta):
	mark_pos = $Marker3D.global_position
	

