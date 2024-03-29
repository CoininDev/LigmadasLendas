extends HeroBase

#P
var p_dano:float
var p_aura:ContinuousCircularArea

#Q
var q_rastro:Node3D
var q_projetil:Node3D
var q_dano:float = 40

#W
var w_dano:float = 20 #quando o W e ativado 
var w_dano2:float = 50#quando ela ataca um viciado com o W ativado
var batk_dano_normal:float=13
var w_tokens:int = 0
var w_ativado:int = 0 #0=nao, 1=w simples ativado, 2=w forte ativado

#R
var r_dano_add:float #dano adicional na passiva
var r_distancia:float

#PROPRIEDADES IMUTAVEIS
func enter():
    p.atk = Attack.new()
    p.atk.apply_to = ["viciado"]
    p.atk.caster = self
    p_aura.time = -1
    p_aura.radius = 10
    p_aura.delay = 0.1
    ability_box.add_child(p_aura)
    

    q.atk = Attack.new()
    q.atk.caster = self
    q.atk.apply_to.append(team_comp.enemy_team_str)
    q.range = 5
    
    w.atk = Attack.new()
    w.atk.caster = self
    
    e.atk = Attack.new()
    e.atk.caster = self
    e.atk.apply_to.append(team_comp.enemy_team_str)
    print("Alyssa ready")

#PROPRIEDADES MUTAVEIS
func _process(_delta):
    print("process")
    if !specified_script_entered:
        specified_script_entered = true
        print("entered")
        enter()
    #P
    p.atk.magic_damage = p_dano + (ability_power * 0.2) + (r_dano_add + (ability_power * 1.2))
    p_aura.global_position = global_position
    p_aura.atk = p.atk
    #Q
    q.target_direction = pointer.global_rotation
    q.atk.magic_damage = q_dano + (ability_power * 0.75)
    print(q.atk)
    #print(q_rastro)
    #if q_rastro and q_projetil: 
        #print(str(position.distance_to(q_projetil.bullet.position)) +" ; "+ str(q_rastro.length))
        #q_rastro.area.position.z = -position.distance_to(q_projetil.bullet.position)/9
        #q_rastro.length = position.distance_to(q_projetil.bullet.position)/2
    #W
    if w_ativado == 1:
        batk_comp.atk_damage = w_dano 
    elif w_ativado == 2:
        batk_comp.atk_damage = w_dano2
    else:
        batk_comp.atk_damage = batk_dano_normal
    if w_tokens <= 0:
        w_ativado = 0
    #E
    e.range = 4 + (ability_power * 0.02)
    e.atk.mark = "viciado"
    e.atk.mark_time = 10

func q_preview():
    pointer.pointer_range = q.range
    pointer.show_direction()

func q_cast():
    #projetil
    q_projetil = load("res://objs/cast/scenes/projectile.tscn").instantiate()
    q_projetil.speed = 10
    q_projetil.atk = q.atk
    q_projetil.gfx.surface_set_material(0,load("res://heroes/alyssa/material/abilities_alyssa.tres"))
    q_projetil.gfx_particles = load("res://heroes/alyssa/material/particles_aura_alyssa.tres")
    q_projetil.radius = 0.25
    q_projetil.distance = 10#q.range
    ability_box.add_child(q_projetil)
    q_projetil.global_rotation = q.target_direction
    q_projetil.global_position = global_position
    
    #anim_comp.cast(1)
    global_rotation = pointer.global_rotation
    #rastro
    #q_rastro = load("res://objs/cast/scenes/continuous_rect_area.tscn").instantiate()
    #q_rastro.atk = Attack.new()
    #q_rastro.atk.slow_time = 0.5
    #q_rastro.atk.caster = selfj
    #q_rastro.length = 0
    #ability_box.add_child(q_rastro)
    #q_rastro.global_rotation = q.target_direction
    #q_rastro.global_position = global_position
    
    pointer.hide_all()

func w_cast():
    w_ativado = 1
    w_tokens = 1

func e_cast():
    var t = load("res://objs/cast/scenes/continuous_circular_area.tscn").instantiate()
    t.atk = e.atk
    t.radius = e.range
    #t.gfx.surface_set_material(0,load("res://heroes/alyssa/material/abilities_alyssa.tres"))
    t.delay = 0.1
    t.pulse = 0.1
    t.time = 3
    ability_box.add_child(t)
    t.global_position = global_position
    #e_p.visible = false

func removed_cast(cast):
    if cast == q_projetil or cast == q_rastro:
        q_projetil = null
        q_rastro = null

func batk_attacked(target):
    if w_ativado:
        w_tokens -=1
    if w_ativado == 1 && target.is_in_group("viciado"):
        w_ativado = 2
        w_tokens = 4
