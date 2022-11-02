extends KinematicBody2D

var health = 3

# animation variables
onready var animation = $AnimationPlayer

func _ready():
	pass # Replace with function body.

func _physics_process(_delta):
	var Player = get_parent().get_node("Player")
	animation.play("Running")
	position += (Player.position - position)/150
	
	# show healthbar
	get_node("Control/HealthBar").value = health

func _on_Area2D_body_entered(body):
	if "Bullet" in body.name:
		health -= 1
	if health <= 0:
		Global.score += 1
		queue_free()
