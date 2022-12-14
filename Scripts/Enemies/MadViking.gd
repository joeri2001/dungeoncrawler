extends KinematicBody2D

onready var Player = get_parent().get_node("Player")

var motion = Vector2()
var max_health = 3
var health = max_health
var speed = 0
var player_in_range = false
var player_in_sight = false

# animation variables
onready var animation = $AnimationPlayer

func _physics_process(_delta):
	SightCheck()
	
	motion += (Vector2(Player.position) - position)
	motion = motion.normalized() * speed
	var _UNUSEDmove_and_collide = move_and_collide(motion)
	
	if health > 0 && !player_in_range || health > 0 && !player_in_sight:
		animation.play("Idle")
	if health > 0 && player_in_range && player_in_sight:
		animation.play("Running")
		position += (Player.position - position)/150
	if health <= 0:
		animation.play("Death")
	
	if player_in_range && player_in_sight:
		speed = 1
	if !player_in_range || !player_in_sight:
		speed = 0
	if health <= 0:
		speed = 0
		
func _process(_delta):
	# show healthbar values
	get_node("Control/HealthBar").max_value = max_health
	get_node("Control/HealthBar").value = health

func _on_Area2D_body_entered(body):
	if "Bullet" in body.name:
		health -= 1
	if "Player" in body.name:
		$Timer.start(0.1)
		yield($Timer, "timeout")
		remove_child($CollisionShape2D)
		remove_child($Area2D)
		health = 0
	if health <= 0:
		Global.coins += 1
		$Timer.start(0.5)
		yield($Timer, "timeout")
		queue_free()

func _on_Sight_body_entered(body):
	if "Player" in body.name:
		player_in_range = true

func _on_Sight_body_exited(body):
	if "Player" in body.name:
		player_in_range = false

func SightCheck():
	if player_in_range:
		var space_state = get_world_2d().direct_space_state
		var sight_check = space_state.intersect_ray(position, Player.position, [self], collision_mask)
		if sight_check:
			if sight_check.collider.name == "Player":
				player_in_sight = true
			else:
				player_in_sight = false
