extends Node2D

var drag_position = Vector2()
var init_camera_pos = Vector2()
var drag = false

const MAP_WIDTH = 960  # Maksymalna szerokość mapy
const MAP_HEIGHT = 480  # Maksymalna wysokość mapy

func _unhandled_input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			if event.pressed:
				# Rozpoczęcie przeciągania
				drag = true
				drag_position = get_global_mouse_position()
				init_camera_pos = $Camera2D.position
			else:
				# Zakończenie przeciągania
				drag = false

func _process(delta):
	if drag:
		# Oblicz różnicę pozycji myszki i przesuwaj kamerę
		var offset = drag_position - get_global_mouse_position()
		var new_position = init_camera_pos + offset
		
		# Ogranicz ruch kamery do granic mapy
		new_position.x = clamp(new_position.x, 0, MAP_WIDTH)
		new_position.y = clamp(new_position.y, -MAP_HEIGHT, 0)
		
		$Camera2D.position = new_position
