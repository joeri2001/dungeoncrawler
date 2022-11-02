extends RigidBody2D

var bullet_speed = 500
var bullet = preload("res://Weapons/Default Weapon/Bullet.tscn")
var canshoot = true

func _ready():
	pass

func _physics_process(_delta):
	look_at(get_global_mouse_position())
	if Input.is_action_pressed("LMB") && canshoot == true:
		canshoot = false
		fire()
		# delay on shooting
		yield(get_tree().create_timer(1.0), "timeout")
		canshoot = true

func fire():
	var bullet_instance = bullet.instance()
	bullet_instance.position = $BulletPoint.get_global_position()
	bullet_instance.rotation_degrees = rotation_degrees
	bullet_instance.apply_impulse(Vector2(), Vector2(bullet_speed, 0).rotated(rotation))
	get_tree().get_root().call_deferred("add_child", bullet_instance)
