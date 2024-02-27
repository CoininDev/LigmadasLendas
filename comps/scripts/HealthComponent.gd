extends Node
class_name HealthComponent

signal died #died se conecta com as unidades que já atacaram o "hero" e ao próprio hero.
signal last_hit #last hit é exclusivo a quem deu o último dano, e serve pra ele receber ouro e xp.
signal damaged

@export var MAX_HEALTH:float = 100
@export var physical_resistance:float = 0
@export var magical_resistance:float = 0
@export var death_xp:float = 100
@export var death_gold:float = 300
@export var hero:Node3D
var health:float

func _ready():
    health = MAX_HEALTH
    died.connect(hero.die)

func damage(atk: Attack):
    atk.physic_damage -= physical_resistance
    atk.magic_damage -= magical_resistance
    
    health -= atk.physic_damage
    health -= atk.magic_damage
    if is_instance_valid(atk.caster):
        if atk.caster.has_method("target_died"):
            if damaged.is_connected(atk.caster.target_died):
                damaged.connect(atk.caster.target_died)
    damaged.emit()
    handle_death(atk)

func damage_continuous(atk: Attack):
    atk.physic_continuous_damage -= physical_resistance
    atk.magic_continuous_damage -= magical_resistance
    
    health -= atk.physic_continuous_damage
    health -= atk.magic_continuous_damage
    damaged.emit()
    
    handle_death(atk)

func heal(healing:float):
    if health < MAX_HEALTH:
        health += healing

func handle_death(atk):
    if health <= 0:
        #if is_instance_valid(atk.caster):
            #if atk.caster.has_method("cancel"):
                #atk.caster.cancel()
            #if "batk_comp" in atk.caster:
                #atk.caster.batk_comp.cancel()
            #if atk.caster.has_method("add_stats"):
                #atk.caster.add_stats(death_xp, death_gold)
        if is_instance_valid(atk.caster):
            if atk.caster.has_method("last_hitted"):
                last_hit.connect(atk.caster.last_hitted)
                last_hit.emit({"xp":death_xp, "gold":death_gold})
        #print(atk.caster)
        died.emit(hero)

func ignore_resistance_damage(atk:Attack):
    health -= atk.physic_damage
    health -= atk.magic_damage
    damaged.emit()
    handle_death(atk)
