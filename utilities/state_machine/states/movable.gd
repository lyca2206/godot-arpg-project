extends State
class_name Movable

var movement_axis = Vector2.ZERO

func update(delta):
	super(delta)
	_request_movement_axis()

func _request_movement_axis():
	movement_axis = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")

func accelerate_towards_axis(delta, axis, acceleration):
	entity.velocity += axis * acceleration * delta

func deaccelerate(delta, deacceleration):
	entity.velocity = entity.velocity.move_toward(Vector2.ZERO, deacceleration * delta)

func cap_to_velocity(velocity):
	entity.velocity = entity.velocity.limit_length(velocity)

func is_movement_axis_zero():
	return movement_axis.is_equal_approx(Vector2.ZERO)
