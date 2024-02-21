extends Node
class_name State
#pra que serve um State?
#Serve para definir estados de uma unidade.
#Por exemplo, a IA de um creep vai ter estados:
	#1: seguir o núcleo inimigo,
	#2: se tiver uma unidade inimiga perto(torre, herói ou creep), ele anda até chegar mais perto
	#3: quando ele estar numa distância interessante dela, ele ataca.
#o State faz parte de uma estrutura que faz esse tipo de programação funcionar.
#é basicamente no que ele vai se basear para mudar seu comportamento diante das condições.

signal transitioned 

func enter() -> void:
	pass
func exit() -> void:
	pass
func update(_delta:float) -> void:
	pass
func physics_update(_delta:float) -> void:
	pass
	
