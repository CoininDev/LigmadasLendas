extends Node3D

@export var health_comp:HealthComponent
@export var sanity_comp:SanityComponent
@export var fx_comp:EffectsComponent
#@export var has_level:bool = false

@onready var health_bar = $SubViewport/HealthBar
@onready var damage_bar = $SubViewport/HealthBar/DamageBar
@onready var damage_bar_timer = $SubViewport/HealthBar/DamageBar/Timer
@onready var bar_sprite = $Sprite3D
@onready var sanity_bar = $SubViewport/SanityBar
@onready var sanity_label = $SubViewport/SanityBar/SanityLabel
@onready var effect_image = $SubViewport/EffectImage
@onready var effect_label = $SubViewport/EffectLabel
func _ready():
	health_bar.max_value = health_comp.MAX_HEALTH
	health_bar.value = health_comp.health
	damage_bar.max_value = health_comp.MAX_HEALTH
	damage_bar.value = health_comp.health
	health_comp.connect("damaged", on_damaged)
	
	if sanity_comp:
		sanity_bar.visible = true
		sanity_label.visible = true
		sanity_bar.max_value = sanity_comp.MAX_SANITY
		sanity_bar.value = sanity_comp.sanity
		sanity_label.text = str(sanity_comp.sanity)

func _process(delta):
	health_bar.value = health_comp.health
	if sanity_comp:
		sanity_bar.value = sanity_comp.sanity
		sanity_label.text = str(sanity_comp.sanity)
	
	effect_label.text = fx_comp.current_effect
	match fx_comp.current_effect:
		"devendo":
			effect_image.texture = load("res://graphics/sprites/dividendo.png")
		"pagar":
			effect_image.texture = load("res://graphics/sprites/pagando.png")
		_:
			effect_image.texture = null

func _on_timer_timeout():
	damage_bar.value = health_comp.health

func on_damaged():
	damage_bar_timer.start()
