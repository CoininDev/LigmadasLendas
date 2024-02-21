extends Node
class_name AnimationComponent

@export var nav_comp:NavigationComponent
@export var batk_comp:BAttackComponent
@export var hero:Node3D
@export var cast_timer:Timer
@export var anim_tree:AnimationTree
#### normas de nomenclatura do AnimationTree:
#idle = está vivo em seu estado normal, não está atacando nem lançando habilidade.
#casting = está lançando habilidades
#attacking = ataque básico
#dead = está morto.
var block:bool = false
var run_blend_val:float = -1
#var atk_blend_val:float = -1

func _ready():
	batk_comp.attacked.connect(attack)
	nav_comp.navigation_finished.connect(idle)
	nav_comp.walking_changed.connect(run)

func _process(delta):
	if !anim_tree["parameters/conditions/idle"]:
		hero.look_at(nav_comp.target_position)
		hero.global_rotation.x = 0 
		hero.global_rotation.z = 0 
	if is_instance_valid(batk_comp.target):
		hero.look_at(batk_comp.target.global_position)
		hero.global_rotation.x = 0 
		hero.global_rotation.z = 0 

func run(walking:bool):
	if walking:
		anim_tree["parameters/conditions/running"] = true
		anim_tree["parameters/conditions/idle"] = false


func attack(target:Node3D):
	anim_tree["parameters/conditions/attacking"] = true
	anim_tree["parameters/conditions/idle"] = false
	#hero.look_at(target.position)
	#hero.global_rotation.x = 0 
	#hero.global_rotation.z = 0 

func idle():
	anim_tree["parameters/conditions/idle"] = true
	anim_tree["parameters/conditions/attacking"] = false
	anim_tree["parameters/conditions/running"] = false
	anim_tree["parameters/conditions/casting"] = false

func cast(number:int):
	anim_tree["parameters/conditions/casting"] = true
	cast_timer.start(anim_tree.get_animation("cast" + str(number)).length)

func _on_cast_timer_timeout():
	anim_tree["parameters/conditions/casting"] = false
