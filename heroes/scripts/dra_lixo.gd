extends HeroBase

var ultada = false
var ult_buff:float = 0
var dano_cont:float = 2

func _ready():
	q.atk = Attack.new()
	w.atk = Attack.new()
	e.atk = Attack.new()
	q.range = 15
	w.range = 15
	e.range = 15

func _process(delta):
	q.atk.physic_damage = 15 + (15 * ult_buff)
	q.atk.magic_continuous_damage = dano_cont
	q.target_direction = q_p.global_rotation
	
	w.atk.physic_damage = 10 + (10 * ult_buff)
	w.atk.magic_continuous_damage = dano_cont
	w.target_position = w_p.global_position
	
	e.atk.physic_damage = 8 + (8 * ult_buff)
	e.atk.magic_continuous_damage = dano_cont
	e.target_direction = q_p.global_rotation

func q_preview():
	q_p.visible = true

func q_cast():
	var t = load("res://objs/targets/cast/projectile.tscn").instantiate()
	t.atk = q.atk
	t.distance = q.range
	t.collide = true
	t.global_rotation = q.target_direction
	ability_box.add_child(t)
