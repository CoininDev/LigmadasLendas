extends Node

@export var player_id = 5:
	set(id):
		player_id = id
		$PlayerInput.set_multiplayer_authority(id)

@export var ability_box:Node
@export var spawn_point_position:Vector3 = Vector3.ZERO
@export var character_name:String = "Alyssa"
@export var team:int = 0

func _ready()->void:
	var character:HeroBase = load(GeneralFuncs.char_dict[character_name]).instantiate()
	character.ability_box = ability_box
	character.spawn_point = $SpawnPoint
	character.alive_state.player_input = $PlayerInput
	character.team_comp.team = team
	add_child(character)
	$CameraMan.point = character
