extends PointLight2D

func _process(delta):
	global_position = get_global_mouse_position()  # Move light to mouse
