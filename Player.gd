extends KinematicBody2D

# movement variables
var max_speed = 250
var acceleration = 20000
var motion = Vector2()

func _physics_process(delta):
	# movement
	var axis = get_input_axis()
	if axis == Vector2.ZERO:
		apply_friction(acceleration * delta)
	else:
		apply_movement(axis * acceleration * delta)
	motion = move_and_slide(motion)
	
	# have player look at mouse cursor
	look_at(get_global_mouse_position())

# movement functions
func get_input_axis():
	var axis = Vector2.ZERO
	axis.x = int(Input.is_action_pressed("right")) - int(Input.is_action_pressed("left"))
	axis.y = int(Input.is_action_pressed("down")) - int(Input.is_action_pressed("up"))
	return axis.normalized()

func apply_friction(amount):
	if motion.length() > amount:
		motion -= motion.normalized() * amount
	else:
		motion = Vector2.ZERO

func apply_movement(acceleration_amount):
	motion += acceleration_amount
	motion = motion.limit_length(max_speed)


