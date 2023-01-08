extends State
class_name Movable

var movement_axis = Vector2.ZERO

func update(delta):
	super(delta)
	_request_movement_axis()

func _request_movement_axis():
	movement_axis = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")

func is_standing_still():
	return entity.velocity.is_zero_approx() && is_movement_axis_zero()

func is_movement_axis_zero():
	return movement_axis.is_equal_approx(Vector2.ZERO)

func is_moving_towards_wall():
	return entity.is_on_wall() && movement_axis.dot(entity.get_wall_normal()) < -0.8
