class_name ProjectileTarget
extends Target

@export var children = {
	"bullet":Area3D,
	"bullet_graph":MeshInstance3D,
	"bullet_col":CollisionShape3D,
	"end":Area3D,
	"end_col":CollisionShape3D,
	"show_range":MeshInstance3D
}
@export var properties = {
	"distance": 15,
	"graph":Mesh,
	"radius": 0.5,
	"speed": 10
}

func create():
	for child in children:
		pass

func _ready():
	pass

func _process(delta):
	pass

func apply():
	pass

func preview():
	pass
