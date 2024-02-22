extends Creep
class_name MinionCreep


@export var enemy_core:Node3D
@export var nav:NavigationComponent
@export_enum("TopLane:2", "MidLane:3", "BotLane:4") var lane:int = 4
@export var ability_box:Node

func _ready():
	nav.set_navigation_layer_value(lane, true)
