class_name AbilitiesComponent
extends Node

var abilities:AbilitiesState
@export var hero:HeroBase

func enter():
    abilities = get_children()[0]
    abilities.hero = hero
    print("ability component enter")
    abilities.enter()

func update(delta):
    abilities.update(delta)

func q_preview():
    if hero.is_blocked("q"): return
    abilities.q_preview()

func w_preview():
    if hero.is_blocked("w"): return
    abilities.w_preview()


func e_preview():
    if hero.is_blocked("e"): return
    abilities.e_preview()


func r_preview():
    if hero.is_blocked("r"): return
    abilities.r_preview()
    
    
func a_preview():
    if hero.is_blocked("opt1"): return
    abilities.a_preview()
    
   
func s_preview():
    if hero.is_blocked("opt2"): return
    abilities.s_preview()


func q_cast():
    if hero.is_blocked("q"): return
    abilities.q_cast()

func w_cast():
    if hero.is_blocked("w"): return
    abilities.w_cast()


func e_cast():
    if hero.is_blocked("e"): return
    abilities.e_cast()


func r_cast():
    if hero.is_blocked("r"): return
    abilities.r_cast()
    
    
func a_cast():
    if hero.is_blocked("opt1"): return
    abilities.a_cast()
    
   
func s_cast():
    if hero.is_blocked("opt2"): return
    abilities.s_cast()
