extends HeroBase

var q_dano = 100
var w_dano = 80
var e_dano = 60

var ultada = false
var ult_buff:float = 0.3
var dano_cont:float = 10

func _ready():
	q.atk = Attack.new()
	w.atk = Attack.new()
	e.atk = Attack.new()
	q.range = 15
	w.range = 15
	e.range = 15
	q.atk.caster = self
	w.atk.caster = self
	e.atk.caster = self

func _process(delta):
	if ultada:
		ult_buff = 0.3
	else:
		ult_buff = 0
	
	
	q.atk.physic_damage = q_dano + (q_dano * ult_buff)
	q.atk.magic_continuous_damage = dano_cont
	q.atk.continuous_damage_time = 5
	q.target_direction = q_p.global_rotation
	
	w.atk.physic_damage = w_dano + (w_dano * ult_buff)
	w.atk.magic_continuous_damage = dano_cont
	w.atk.continuous_damage_time = 5
	w.target_position = w_p.mark_pos
	
	e.atk.physic_damage = e_dano + (e_dano * ult_buff)
	e.atk.magic_continuous_damage = dano_cont
	e.target_direction = e_p.global_rotation
	e.atk.continuous_damage_time = 5

func q_preview():
	q_p.mesh_instance.position.z = -q.range / 2
	q_p.mesh_instance.scale.z = q.range
	q_p.visible = true

func q_cast():
	var t = load("res://objs/targets/cast/projectile.tscn").instantiate()
	t.atk = q.atk
	t.distance = q.range
	t.radius = 0.25
	t.speed = 30
	t.collide = true
	t.global_rotation = q.target_direction
	ability_box.add_child(t)
	t.global_position = global_position
	q_p.visible = false

func w_preview():
	w_p.visible = true

func w_cast():
	var t = load("res://objs/targets/cast/circular_area.tscn").instantiate()
	t.atk = w.atk
	t.delay = 0.7
	t.radius = 3
	ability_box.add_child(t)
	t.global_position = w.target_position
	w_p.visible = false

func e_preview():
	e_p.mesh_instance.position.z = -e.range / 2
	e_p.mesh_instance.scale.z = e.range
	e_p.mesh_instance.scale.x = e.range /3
	e_p.visible = true

func e_cast():
	var offset = -0.2
	for i in 5:
		var t = load("res://objs/targets/cast/projectile.tscn").instantiate()
		t.atk = e.atk
		t.distance = e.range
		t.speed = 15
		t.radius = 0.25
		t.collide = true
		t.global_rotation = e.target_direction - Vector3(0,offset,0)
		ability_box.add_child(t)
		t.global_position = global_position
		offset += 0.1
	e_p.visible = false
	

func r_cast():
	ultada = true
	$MeshInstance3D.mesh.material = load("res://graphics/arerer.tres")
	$UltTimer.start()

func _on_ult_timer_timeout():
	$MeshInstance3D.mesh.material = load("res://graphics/dra_lixo.tres")
	ultada = false
