extends CharacterBody2D
class_name StateMachine

@export var initial_state: String
@export var is_debug_enabled: bool
@onready var animation_tree = $AnimationTree

var available_states: Dictionary
var current_state: State

func _ready():
	if has_node("States"):
		_initialize_available_states()
		_set_current_state(initial_state)
	else:
		send_debug_message(str(name) + " does not contain the 'States' node.")

func _initialize_available_states():
	var states = _retrieve_states()
	_setup_and_set_available(states)

func _retrieve_states():
	return get_node("States").get_children()

func _setup_and_set_available(states):
	for state in states:
		state.setup(self)
		available_states[state.name] = state

func _set_current_state(key):
	if available_states.has(key):
		current_state = available_states[key]
	else:
		send_debug_message("State '" + str(key) + "' does not exist inside " + str(name) + ".")

func send_debug_message(message):
	if is_debug_enabled:
		print(message)

func _unhandled_input(event: InputEvent):
	_call_method_from_state("input", [event])

func _process(delta):
	_call_method_from_state("update", [delta])

func _physics_process(delta):
	_call_method_from_state("physics_update", [delta])

func change_state(key):
	_call_method_from_state("exit")
	_set_current_state(key)
	_call_method_from_state("enter")

func _call_method_from_state(method_name, arguments = []):
	if current_state != null:
		current_state.callv(method_name, arguments)

func change_animation_state(key):
	animation_tree.get("parameters/playback").travel(key)
