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

func _on_Area2D_body_entered(body):
	if "Bullet" in body.name:
		health -= 1
	if health <= 0:
		queue_free()
