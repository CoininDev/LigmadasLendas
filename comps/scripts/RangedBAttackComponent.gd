extends BAttackComponent
class_name RangedBAttackComponent

signal cancel_bullet
@export var bullet_col:Shape3D
@export var bullet_gfx:Mesh
@export var bullet_gfx_particles:Mesh
@export var bullet_speed:float = 0.5
@onready var bullet:PackedScene = load("res://comps/scenes/b_attack_bullet.tscn")



func _ready():
	var escala = 0.4
	range_show.scale.x = range * escala
	range_show.scale.z = range * escala
	area_col.shape.radius = range
	timer.timeout.connect(timeout)
	timer.wait_time = atk_cooldown

func _input(_event):
	for cancelling_action in cancelling_actions:
		if Input.is_action_just_pressed(cancelling_action) or Input.is_action_just_released(cancelling_action):
			cancel()

#func walk():
	#nav_comp.select_destiny(target.position, range-0.2)

 
func attack():
	var bul = bullet.instantiate()
	bul.col = bullet_col
	bul.gfx = bullet_gfx
	bul.gfx_particles = bullet_gfx_particles
	bul.speed = bullet_speed
	bul.target = target
	bul.atk = Attack.new()
	bul.atk.physic_damage = atk_damage
	bul.atk.caster = hero
	attacked.emit(target)
	cancel_bullet.connect(bul.cancel)
	hero.ability_box.add_child(bul)
	bul.global_position = global_position
	

#func timeout():
	#timer.wait_time = atk_cooldown
	#var distance = target.global_position.distance_to(global_position)
	#if distance <= range:
		#attack()

#func select_target(x:Node3D):
	##bullet.queue_free()
	#if !blocked:
		#target = x

func cancel():
	cancel_bullet.emit()
	target = null
