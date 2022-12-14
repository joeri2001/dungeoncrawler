extends RigidBody2D

var bullet_speed = 500
var bullet = preload("res://Scenes/Weapon/Bullet.tscn")
var canshoot = true
var shot_timer = 1.0
# animation variables
onready var animation = $AnimationPlayer

func _ready():
	pass

func _physics_process(_delta):
	look_at(get_global_mouse_position())
	if Input.is_action_pressed("LMB") && canshoot == true && Global.ammo > 0:
		canshoot = false
		fire()
		Global.ammo -= 1
		animation.play("Reload")
		# delay on shooting
		if Global.shot_timer < 0.7:
			shot_timer = 0.7
		else:
			shot_timer = Global.shot_timer
		$Timer.start(shot_timer)
		yield($Timer, "timeout")
		canshoot = true

func fire():
	var bullet_instance = bullet.instance()
	bullet_instance.position = $BulletPoint.get_global_position()
	bullet_instance.rotation_degrees = rotation_degrees
	bullet_instance.apply_impulse(Vector2(), Vector2(bullet_speed, 0).rotated(rotation))
	get_tree().get_root().call_deferred("add_child", bullet_instance)
	$ShootingSound.play()
