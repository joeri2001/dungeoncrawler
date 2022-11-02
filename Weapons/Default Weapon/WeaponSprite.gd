extends Sprite

func _process(delta):
	var vert = get_global_mouse_position()
	var gpos = self.get_global_position()

	if gpos.x < vert.x:
		self.set_flip_v(false)
		vert.x = -vert.x # our sprite would be facing away from the mouse after flipping
	else:
		self.set_flip_v(true)
