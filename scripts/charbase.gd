extends CharacterBody3D
@export var max_health = 100
@export var raw_armor = 25
@export var raw_magic_resistance = 25
@export var raw_psycho_resistance = 25
@export var raw_physic_power = 50
@export var raw_magic_power = 50
@export var raw_psycho_power = 50
@export var raw_speed = 500
var speed = raw_speed
var armor = raw_armor
var magic_resistance = raw_magic_resistance
var psycho_resistance = raw_psycho_resistance
var physic_power = raw_physic_power
var magic_power = raw_magic_power
var psycho_power = raw_psycho_power

@export var effects = {
	"marca": false
}

@export_category("Habilidades")

@export_group("Q")
@export var q_target:PackedScene = preload("res://objs/targets/projectile.tscn")
@export var q_effects:Dictionary
@export var q_properties:Dictionary
@export var q_apply_to:Array

@export_group("W")
@export var w_target:PackedScene = preload("res://objs/targets/projectile.tscn")
@export var w_effects:Dictionary
@export var w_properties:Dictionary
@export var w_apply_to:Array

@export_group("E")
@export var e_target:PackedScene = preload("res://objs/targets/projectile.tscn")
@export var e_effects:Dictionary
@export var e_properties:Dictionary
@export var e_apply_to:Array

@export_group("R")
@export var r_target:PackedScene = preload("res://objs/targets/circular_area.tscn")
@export var r_effects:Dictionary
@export var r_properties:Dictionary
@export var r_apply_to:Array

@onready var navagent = $NavigationAgent3D
#funções centrais
func _process(delta):
	if navagent.is_navigation_finished():
		return
	move(delta)
	
	
func _input(event):
	select_target()
	if Input.is_action_just_pressed("q"):
		cast_Q()
	if Input.is_action_just_pressed("w"):
		cast_W()
	if Input.is_action_just_pressed("e"):
		cast_E()
	if Input.is_action_just_pressed("r"):
		cast_R()
#movimento
func select_target():
	if Input.is_action_pressed("mright"):
		#converter o ponto do mouse na tela 2d para um ponto 3d no jogo.
		#para isso é preciso criar um raio, uma linha reta que parte da camera e segue até encontrar uma colisão.
		var camera = get_tree().get_nodes_in_group("camera")[0]
		var mousepos = get_viewport().get_mouse_position()
		var raylen = 1000
		var from = camera.project_ray_origin(mousepos)
		var to = from + camera.project_ray_normal(mousepos) * raylen
		var space = get_world_3d().direct_space_state
		var rayquery = PhysicsRayQueryParameters3D.new()
		rayquery.from = from
		rayquery.to = to
		var result = space.intersect_ray(rayquery)
		if result.has("position"):
			navagent.target_position = result.position
func move(delta):
	var targetpos = navagent.get_next_path_position()
	var dir = global_position.direction_to(targetpos)
	look_at(Vector3(targetpos.x, global_position.y, targetpos.z), Vector3.UP)#olhar para a direção certa
	velocity = dir * speed * delta
	move_and_slide()
#habilidades

func cast_Q():
	var q = q_target.instantiate()
	for effect in q_effects:
		q.effects[effect] = q_effects[effect]
	for property in q_properties:
		q.properties[property] = q_properties[property]
	q.caster = self
	q.apply_to = q_apply_to
	q.button = "q"
	get_parent().add_child(q)
	

func cast_W():
	var w = w_target.instantiate()
	for effect in w_effects:
		w.effects[effect] = w_effects[effect]
	for property in w_properties:
		w.properties[property] = w_properties[property]
	w.caster = self
	w.apply_to = w_apply_to
	w.button = "w"
	get_parent().add_child(w)
	

func cast_E():
	var e = e_target.instantiate()
	for effect in e_effects:
		e.effects[effect] = e_effects[effect]
	for property in e_properties:
		e.properties[property] = e_properties[property]
	e.caster = self
	e.apply_to = e_apply_to
	e.button = "e"
	get_parent().add_child(e)
	

func cast_R():
	var r = r_target.instantiate()
	for effect in r_effects:
		r.effects[effect] = r_effects[effect]
	for property in r_properties:
		r.properties[property] = r_properties[property]
	r.caster = self
	r.apply_to = r_apply_to 
	r.button = "r"
	get_parent().add_child(r)
	
