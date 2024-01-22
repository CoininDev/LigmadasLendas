extends Node3D


func _ready():
	var hero = HeroBase.new()
	hero.comps["gfx"].mesh = CylinderMesh.new()
	hero.position = $"hero spawn".position
	add_child(hero)
	
	var saco_de_pancada = HeroBase.new()
	saco_de_pancada.mover = false
	saco_de_pancada.comps["gfx"].mesh = CylinderMesh.new()
	saco_de_pancada.comps["gfx"].mesh.material = load("res://graphics/gold.tres")
	saco_de_pancada.position = Vector3(0,1,0)
	add_child(saco_de_pancada)

func _process(delta):
	pass
