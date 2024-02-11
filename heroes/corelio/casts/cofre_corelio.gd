extends Node3D

@export var atk:Attack
@export var dinheiro:float
@export var apply_to:Array = ["hitbox_owner"]
@export var radius:float = 2
@export var delay:float = 10
@onready var area = $Area3D
@export var dmgr:DamageMgrComponent


var type = "ward"
func _ready():
	$Timer.start(delay)


func _on_timer_timeout():
	queue_free()

func die():
	var t = load("res://objs/cast/scenes/circular_area.tscn").instantiate()
	t.atk = atk
	t.delay = 0.1
	t.radius = radius
	atk.caster.ability_box.add_child(t)
	t.corelio_Passiva = true
	t.global_position = self.global_position
	queue_free()
