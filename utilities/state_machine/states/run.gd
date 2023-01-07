extends Movable
class_name Run

@export var ACCELERATION = 2000
@export var DEACCELERATION = 2000
@export var MAX_VELOCITY = 100

func update(delta):
	super(delta)
	_set_anims_with_movement_axis()
	_change_to_idle_on_condition()

func _set_anims_with_movement_axis():
	if not is_movement_axis_zero():
		entity.animation_tree.set("parameters/Idle/blend_position", movement_axis)
		entity.animation_tree.set("parameters/Run/blend_position", movement_axis)

func _change_to_idle_on_condition():
	if _is_standing_still() || _is_moving_towards_wall():
		entity.change_state("Idle")

func _is_standing_still():
	return entity.velocity.is_zero_approx() && is_movement_axis_zero()

func _is_moving_towards_wall():
	return entity.is_on_wall() && movement_axis.dot(entity.get_wall_normal()) < -0.8

func physics_update(delta):
	super(delta)
	_apply_acceleration(delta)
	cap_to_velocity(MAX_VELOCITY)
	entity.move_and_slide()

func _apply_acceleration(delta):
	if is_movement_axis_zero():
		deaccelerate(delta, DEACCELERATION)
	else:
		accelerate_towards_axis(delta, movement_axis, ACCELERATION)

func enter():
	super()
	entity.change_animation_state("Run")
