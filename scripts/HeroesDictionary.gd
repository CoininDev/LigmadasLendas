class_name HeroesDictionary
extends Node

var hero_dict:Dictionary = {
    "alyssa": ["res://heroes/alyssa/alyssa.gd"],
    "chuu": ["res://heroes/chuu/chuu.gd"],
    "corelio":["res://heroes/corelio/corelio.gd"],
    "dra_lixo":["res://heroes/dra_lixo/dra_lixo.gd"]
}

func get_hero_script(hero_name:String):
    return hero_dict[hero_name][0]
