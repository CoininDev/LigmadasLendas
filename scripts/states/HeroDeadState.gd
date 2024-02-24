extends State
class_name HeroDeadState

@export var fx_comp:EffectsComponent
@export var sanity_comp:SanityComponent
@export var health_comp:HealthComponent
@export var hero:HeroBase
@export var hero_col:CollisionShape3D
var death_time:float

var death_time_count:float = 0

func enter():
	death_time_count = death_time
	hero_col.disabled = true
	fx_comp.cancel_all()
	sanity_comp.timer.stop()

func update(delta:float):
	if death_time_count > 0:
		death_time_count -= delta
	else:
		transitioned.emit(self, "HeroAliveState")
