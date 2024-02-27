class_name HeroesDictionary
extends Node

var hero_dict:Dictionary = {
    "alyssa": ["res://heroes/alyssa/alyssa.gd"],
    "chuu": ["res://heroes/chuu/chuu.gd"],
    "corelio":["res://heroes/corelio/corelio.gd"],
    "dra_lixo":[DraLixoAbilities]
}

func get_hero_abilities(hero_name:String):
    return hero_dict[hero_name][0]
