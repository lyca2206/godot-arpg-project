extends Node
class_name StateMachine

@export var entity: Node
@export var initial_state: String

var available_states: Dictionary
var current_state

func _ready():
	_initialize_available_states()
	_set_current_state(initial_state)

func _initialize_available_states():
	var states = get_children()
	for state in states:
		state.setup(entity)
		available_states[state.name] = state

func _set_current_state(key):
	if available_states.has(key):
		current_state = available_states[key]

func change_state(key):
	_call_method_from_state("exit")
	_set_current_state(key)
	_call_method_from_state("enter")

func input(event: InputEvent):
	_call_method_from_state("input", [event])

func update(delta):
	_call_method_from_state("update", [delta])

func physics_update(delta):
	_call_method_from_state("physics_update", [delta])

func _call_method_from_state(method_name, arguments = []):
	if current_state != null:
		current_state.callv(method_name, arguments)
