extends KinematicBody2D

var max_health = 3
var health = max_health

# animation variables
onready var animation = $AnimationPlayer

func _process(_delta):
	# show healthbar values
	get_node("Control/HealthBar").max_value = max_health
	get_node("Control/HealthBar").value = health
	
	if max_health > 3 * Global.difficulty:
		max_health += 0.1

func _physics_process(_delta):
	var Player = get_parent().get_node("Player")
	if health > 0:
		animation.play("Running")
		position += (Player.position - position)/150
	if health <= 0:
		animation.play("Death")

func _on_Area2D_body_entered(body):
	if "Bullet" in body.name:
		health -= 1
	if health <= 0:
		Global.score += 1
		Global.difficulty += 1
		$Timer.start(0.5)
		yield($Timer, "timeout")
		queue_free()
