extends CharacterBody2D

var is_dragging = false
var touchpos = Vector2.ZERO

func _input(event):
	if event is InputEventMouseButton:
		if event.is_pressed():
			# Check if the mouse is over the sprite when clicked
			if $Sprite2D.get_rect().has_point($Sprite2D.to_local(event.position)):
				is_dragging = true
				touchpos = event.position
		else:
			# Stop dragging on mouse release
			is_dragging = false

	elif event is InputEventMouseMotion and is_dragging:
		# Update touch position only if dragging
		touchpos = event.position

func _physics_process(delta):
	# Only update sprite position if dragging
	if is_dragging:
		$Sprite2D.global_position = touchpos
