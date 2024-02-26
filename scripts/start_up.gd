extends Node
class_name StartUpNode

@export var PORT = 6969
var charname:String = "dra_lixo"
var charteam:int = 0

func _on_char_textbox_text_set():
	charname = $UI/VBoxContainer/char_textbox.text

func _on_team_numbox_value_changed(value:float):
	charteam = floor(value)

func _on_btn_server_pressed()->void:
	print("Criando um servidor...")
	var server:ENetMultiplayerPeer = ENetMultiplayerPeer.new()
	server.create_server(PORT, 4)
	multiplayer.multiplayer_peer = server
	start_game()

func _on_btn_client_pressed()->void:
	print("Entrando no servidor...")
	var ip:String = "127.0.0.1"
	var client:ENetMultiplayerPeer = ENetMultiplayerPeer.new()
	client.create_client(ip, PORT)
	multiplayer.multiplayer_peer = client
	start_game()

func start_game()->void:
	$UI.hide()
	if multiplayer.is_server():
		change_level.call_deferred(load("res://cenas/mapa.tscn"))

func change_level(scene:PackedScene)->void:
	var game:Node = $Game
	var map:Mapa = scene.instantiate()
	map.start_up_node = self
	for c in game.get_children():
		game.remove_child(c)
		c.queue_free()
	game.add_child(map)
