extends Node
class_name StateMachineComponent
@export var initial_state:State
var current_state:State
var states:Dictionary = {}


func _ready():
	for child in get_children():
		if child is State:
			states[child.name.to_lower()] = child
			child.transitioned.connect(on_child_transition)
	if initial_state:
		initial_state.enter()
		current_state = initial_state

func _process(delta):
	if current_state:
		current_state.update(delta)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if current_state:
		current_state.physics_update(delta)

func on_child_transition(state:State, new_state_name:String):
	if state != current_state:
		return
	
	var new_state:State = states.get(new_state_name.to_lower())
	if not new_state:
		return
	
	if current_state:
		current_state.exit()
	
	new_state.enter()
	current_state = new_state
