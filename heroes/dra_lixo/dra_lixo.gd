class_name DraLixo
extends HeroBase

var q_cooldown_val:float
var w_cooldown_val:float
var e_cooldown_val:float
var r_cooldown_val:float
var q_dano = 100
var w_dano = 80
var e_dano = 60
var ult_buff_set = 0.3
var ultada = false

var ult_time_max:float  = 15
var ult_time:float  = 15
var ult_buff:float = 0
var dano_cont:float = 10

func _ready():
	_ready_base()
	q.atk = Attack.new()
	w.atk = Attack.new()
	e.atk = Attack.new()
	q.range = 15
	w.range = 15
	e.range = 15
	q.atk.caster = self
	q.atk.apply_to.append(team_comp.enemy_team_str)
	w.atk.caster = self
	w.atk.apply_to.append(team_comp.enemy_team_str)
	e.atk.caster = self
	e.atk.apply_to.append(team_comp.enemy_team_str)
	
	print(q_cooldown.time_left)

func _process(delta):
	_process_base(delta)
	if ultada: ult_buff = ult_buff_set
	else: ult_buff = 0
	q.atk.physic_damage = q_dano + (q_dano * ult_buff)
	q.atk.magic_continuous_damage = dano_cont
	q.atk.continuous_damage_time = 5
	q.target_direction = pointer.global_rotation
	
	w.atk.physic_damage = w_dano + (w_dano * ult_buff)
	w.atk.magic_continuous_damage = dano_cont
	w.atk.continuous_damage_time = 5
	w.target_position = pointer.mouse_pos
	
	e.atk.physic_damage = e_dano + (e_dano * ult_buff)
	e.atk.magic_continuous_damage = dano_cont
	e.target_direction = pointer.global_position
	e.atk.continuous_damage_time = 5

	if ultada:
		ult_time -= delta
		if ult_time <= 0:
			ultada = false
			ult_time = ult_time_max
			_on_ult_timer_timeout()

func q_preview():
	if is_blocked("q"): return
	pointer.pointer_range = q.range
	pointer.show_direction()

func q_cast():
	if is_blocked("q"): return
	var t = load("res://objs/cast/scenes/projectile.tscn").instantiate()
	t.atk = q.atk
	t.distance = q.range
	t.radius = 0.25
	t.speed = 30
	t.collide = true
	ability_box.add_child(t)
	t.global_rotation = q.target_direction
	t.global_position = global_position
	pointer.hide_all()
	start_cooldown("q", q_cooldown_val)

func w_preview():
	if is_blocked("w"): return
	pointer.show_circle(3)

func w_cast():
	if is_blocked("w"): return
	var t = load("res://objs/cast/scenes/circular_area.tscn").instantiate()
	t.atk = w.atk
	t.delay = 0.7
	t.radius = 3
	ability_box.add_child(t)
	t.global_position = w.target_position
	pointer.hide_all()
	start_cooldown("w", w_cooldown_val)

func e_preview():
	if is_blocked("e"): return
	pointer.show_cone(0.66)
	

func e_cast():
	if is_blocked("e"): return
	var offset = -0.2
	for i in 5:
		var t = load("res://objs/cast/scenes/projectile.tscn").instantiate()
		t.atk = e.atk
		t.distance = e.range
		t.speed = 15
		t.radius = 0.25
		t.collide = true
		ability_box.add_child(t)
		t.global_rotation = e.target_direction - Vector3(0,offset,0)
		t.global_position = global_position
		offset += 0.1
	pointer.hide_all()
	start_cooldown("e", e_cooldown_val)

func r_cast():
	if is_blocked("r"): return
	ultada = true
	$MeshInstance3D.mesh.material = load("res://graphics/materials/arer_generico.tres")
	start_cooldown("r", r_cooldown_val)

func _on_ult_timer_timeout():
	$MeshInstance3D.mesh.material = load("res://graphics/materials/dra_lixo.tres")
	ultada = false
