extends Movable
class_name Idle

func update(delta):
	super(delta)
	_set_anims_with_movement_axis()
	_change_to_run_on_movement()

func _set_anims_with_movement_axis():
	if not is_movement_axis_zero():
		entity.set_anim_blend_position("Idle", movement_axis)

func _change_to_run_on_movement():
	if not is_movement_axis_zero() and not is_moving_towards_wall():
		entity.reset_velocity()
		entity.change_state("Run")

func enter():
	super()
	entity.change_animation_state("Idle")
