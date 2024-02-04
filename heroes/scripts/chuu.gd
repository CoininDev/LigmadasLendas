extends HeroBase

var w_dano = 70
var q_dano = 30
var q_tempo = 2
var e_dano = 60
var e_range = 3

func _ready():
	q.atk = Attack.new()
	w.atk = Attack.new()
	e.atk = Attack.new()
	q.range = 5
	w.range = 2.1
	q.atk.caster = self
	w.atk.caster = self
	e.atk.caster = self

func _process(delta):
	q.atk.physic_continuous_damage = q_dano * buff
	q.atk.continuous_damage_time = q_tempo
	q.target_direction = q_p.global_rotation
	w.atk.physic_damage = w_dano * buff
	w.atk.stun_time = 3
	e.atk.physic_damage = e_dano
	e.range = e_range
	
func q_preview():
	q_p.mesh_instance.position.z = -q.range/2
	q_p.mesh_instance.scale.z = q.range
	q_p.mesh_instance.scale.x = q.range
	q_p.mesh_instance.mesh.material = load("res://graphics/cone_pointer.tres")
	q_p.visible = true
	
func q_cast():
	var t = load("res://objs/targets/cast/cone_90.tscn").instantiate()
	t.atk = q.atk
	t.distance = q.range
	t.speed = 10
	t.collide = false
	t.global_rotation = q.target_direction
	ability_box.add_child(t)
	t.global_position = global_position
	q_p.visible = false

func w_preview():
	w_p.range = w.range
	w_p.visible = true

func w_cast():
	var result = GeneralFuncs.mouse_raycast_entity()
	if result:
		if result.collider.position.distance_to(position) <= w.range:
			result.collider.damage(w.atk)
	w_p.visible = false
	
