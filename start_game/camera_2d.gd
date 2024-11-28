extends Camera2D

var dragging = false
var last_mouse_position = Vector2()

func _ready():
	# Set camera to follow the target or set it to a fixed position
	# You can remove the follow target if you just want free dragging
	self.offset = Vector2()  # Reset any camera offset if needed

func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			if event.pressed:
				# Start dragging
				dragging = true
				last_mouse_position = event.position
			else:
				# Stop dragging
				dragging = false

	elif event is InputEventMouseMotion and dragging:
		# Calculate how much the mouse has moved since the last frame
		var delta = event.position - last_mouse_position
		# Move the camera accordingly
		position -= delta
		# Update the last mouse position for the next frame
		last_mouse_position = event.position
