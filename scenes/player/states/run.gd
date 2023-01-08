extends Movable
class_name Run

@export var ACCELERATION = 2000
@export var DEACCELERATION = 2000
@export var MAX_VELOCITY = 100

func update(delta):
	super(delta)
	_set_anims_with_movement_axis()
	_change_to_idle_on_still()

func _set_anims_with_movement_axis():
	if not is_movement_axis_zero():
		entity.set_anim_blend_position("Idle", movement_axis)
		entity.set_anim_blend_position("Run", movement_axis)

func _change_to_idle_on_still():
	if is_standing_still() or is_moving_towards_wall():
		entity.change_state("Idle")

func physics_update(delta):
	super(delta)
	_apply_acceleration(delta)
	entity.cap_to_velocity(MAX_VELOCITY)
	entity.move_and_slide()

func _apply_acceleration(delta):
	if is_movement_axis_zero():
		entity.deaccelerate(DEACCELERATION * delta)
	else:
		entity.accelerate_towards_axis(movement_axis, ACCELERATION * delta)

func enter():
	super()
	entity.change_animation_state("Run")
