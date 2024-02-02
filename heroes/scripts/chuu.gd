extends HeroBase

var q_dano = 70
var w_dano = 30
var w_tempo = 2
var e_dano = 60
var e_range = 3

func _ready():
	q.atk = Attack.new()
	w.atk = Attack.new()
	e.atk = Attack.new()
	q.range = 3
	w.range = 3
	q.atk.caster = self
	w.atk.caster = self
	e.atk.caster = self

func _process(delta):
	q.atk.physic_damage = q_dano * buff
	w.atk.physic_continuous_damage = w_dano * buff
	w.atk.continuous_damage_time = w_tempo
	e.atk.physic_damage = e_dano
	e.range = e_range
