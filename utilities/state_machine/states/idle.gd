extends Movable
class_name Idle

func update(delta):
	super(delta)
	_set_anims_with_movement_axis()
	_change_to_run_on_movement()

func _set_anims_with_movement_axis():
	if not is_movement_axis_zero():
		entity.animation_tree.set("parameters/Idle/blend_position", movement_axis)

func _change_to_run_on_movement():
	if not is_movement_axis_zero() && (not entity.is_on_wall() || _not_moving_towards_wall()):
		entity.velocity = Vector2.ZERO
		entity.change_state("Run")

func _not_moving_towards_wall():
	return movement_axis.dot(entity.get_wall_normal()) > -0.8

func enter():
	super()
	entity.change_animation_state("Idle")
