extends RigidBody2D

# animation variables
onready var animation = $AnimationPlayer

func _ready():
	pass # Replace with function body.

func _on_Area2D_body_entered(body):
	if "MadViking" in body.name:
		animation.play("bullet_explosion")
		$Timer.start(0.4)
		yield($Timer, "timeout")
		queue_free()
