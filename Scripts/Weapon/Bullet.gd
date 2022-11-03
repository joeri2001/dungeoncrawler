extends RigidBody2D

# animation variables
onready var animation = $AnimationPlayer

func _on_Area2D_body_entered(body):
	if "MadViking" in body.name || body is TileMap:
		animation.play("bullet_explosion")
		$Timer.start(0.4)
		yield($Timer, "timeout")
		queue_free()
