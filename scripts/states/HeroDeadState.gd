extends State
class_name HeroDeadState

@export var fx_comp:EffectsComponent
@export var sanity_comp:SanityComponent
@export var hero:HeroBase
var death_time:float

var death_time_count:float = 0

func enter():
	death_time_count = death_time
	
	fx_comp.cancel_all()
	sanity_comp.timer.stop()
	print("coco inevitável")
	for child in hero.get_children():
		if child.name.to_lower() == "collisionshape3d":
			child.disabled = true
			break

func update(delta:float):
	if death_time_count > 0:
		death_time_count -= delta
	else:
		transitioned.emit(self, "HeroAliveState")
