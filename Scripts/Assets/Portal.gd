extends Sprite

# animation variables
onready var animation = $AnimationPlayer

func _physics_process(_delta):
	animation.play("Idle")

func _on_Area2D_body_entered(body):
	if "Player" in body.name:
		var _UNUSEDchange_scene = get_tree().change_scene("res://Scenes/World.tscn")
	
