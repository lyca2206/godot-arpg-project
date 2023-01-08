extends CharacterBody2D

@onready var state_machine = $StateMachine
@onready var animation_tree = $AnimationTree

func _unhandled_input(event: InputEvent):
	state_machine.input(event)

func _process(delta):
	state_machine.update(delta)

func _physics_process(delta):
	state_machine.physics_update(delta)

func reset_velocity():
	velocity = Vector2.ZERO

func cap_to_velocity(_velocity):
	velocity = velocity.limit_length(_velocity)

func accelerate_towards_axis(normalized_vector, acceleration):
	velocity += normalized_vector * acceleration

func deaccelerate(deacceleration):
	velocity = velocity.move_toward(Vector2.ZERO, deacceleration)

func change_state(key):
	state_machine.change_state(key)

func change_animation_state(state_name):
	animation_tree.get("parameters/playback").travel(state_name)

func set_anim_blend_position(anim_name, normalized_vector):
	animation_tree.set("parameters/" + anim_name + "/blend_position", normalized_vector)
