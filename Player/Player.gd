extends KinematicBody2D

# movement variables
var max_speed = 250
var acceleration = 20000
var motion = Vector2()

# animation variables
onready var animation = $AnimationPlayer

# health
var health = 5

func _physics_process(delta):
	# movement
	var axis = get_input_axis()
	if axis == Vector2.ZERO:
		apply_friction(acceleration * delta)
	else:
		apply_movement(axis * acceleration * delta)
	motion = move_and_slide(motion)
	
	# animations
	var running = Input.is_action_pressed("up") || Input.is_action_pressed("down") || Input.is_action_pressed("right") || Input.is_action_pressed("left")
	var right = Input.is_action_pressed("right")
	var left = Input.is_action_pressed("left")
	if running:
		animation.play("Running")
	else:
		animation.play("Idle")
	if right:
		$Sprite.flip_h = false
	if left:
		$Sprite.flip_h = true
	
	# make healthbar display health
	get_node("Control/HealthBar").value = health


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

func kill():
	get_tree().reload_current_scene()

func _on_Area2D_body_entered(body):
	if "MadViking" in body.name:
		health -= 1
	if health <= 0:
		kill()
