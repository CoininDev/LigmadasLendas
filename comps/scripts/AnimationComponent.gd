extends Node
class_name AnimationComponent

@export var nav_comp:NavigationComponent
@export var batk_comp:BAttackComponent
@export var hero:Node3D
@export var block_timer:Timer
var anim_player:AnimationPlayer
var block:bool = false

#var run_blend_val:float = -1
#var atk_blend_val:float = -1

func _ready():
	batk_comp.attacked.connect(attack)
	nav_comp.navigation_finished.connect(idle)
	nav_comp.walking_changed.connect(run)

func _process(delta):
	#set("parameters/run_blend1s/blend_position", lerp(float(get("parameters/run_blend1s/blend_position")), run_blend_val, 0.5))
	#set("parameters/run_blend1s/0/blend_position", lerp(float(get("parameters/run_blend1s/0/blend_position")), atk_blend_val, 0.4))
	#print("run " + str(get("parameters/run_blend1s/blend_position")))
	#print("atk " + str(get("parameters/run_blend1s/0/blend_position")))
	if anim_player.current_animation == "run":
		hero.look_at(nav_comp.target_position)
		hero.global_rotation.x = 0 
		hero.global_rotation.z = 0 
	elif anim_player.current_animation == "":
		idle()

func run(walking:bool):
	if walking:
		anim_player.play("run")  
	#run_blend_val = 1


func attack(target:Node3D):
	if !block:
		anim_player.play("attack")
		hero.look_at(target.position)
		hero.global_rotation.x = 0 
		hero.global_rotation.z = 0 
		#atk_blend_val = 1

func idle():
	#print("idle")
	anim_player.play("idle")
	#run_blend_val = -1
	#atk_blend_val = -1

func cast(number:int):
	anim_player.play("cast" + str(number))
	block = true
	block_timer.start(anim_player.get_animation("cast" + str(number)).length)
	

func _on_block_timer_timeout():
	block = false
