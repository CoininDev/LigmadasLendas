extends Node3D
class_name  Mapa
@export var start_up_node:StartUpNode
@export var blue_team_players:Array
@export var red_team_players:Array
@export var blue_spawn_point_positions:Array
@export var red_spawn_point_positions:Array
@export var ability_box:Node

func _ready()->void:
	if not multiplayer.is_server(): return
	
	multiplayer.peer_connected.connect(add_player)
	multiplayer.peer_disconnected.connect(del_player)

	for id in multiplayer.get_peers():
		add_player(id)
	if not OS.has_feature("dedicated_server"):
		add_player(1)

func add_player(id: int)->void:
	var player = preload("res://cenas/player.tscn").instantiate()
	player.name = str(id)
	player.character_name = start_up_node.charname
	player.ability_box = ability_box
	player.set("player_id", id)
	if start_up_node.charteam == 0: $Players/BlueTeam.add_child(player)
	elif start_up_node.charteam == 1: $Players/RedTeam.add_child(player)
	else: print("Erro ao adicionar player %d: Time %d não encontrado, use 0 para azul ou 1 para vermelho" % [id, start_up_node.charteam])

func del_player(id: int)->void:
	if not $Players.has_node(str(id)): return
	$Players.get_node(str(id)).queue_free()

func _exit_tree()->void:
	if not multiplayer.is_server(): return
	
	multiplayer.peer_connected.disconnect(add_player)
	multiplayer.peer_disconnected.disconnect(del_player)
