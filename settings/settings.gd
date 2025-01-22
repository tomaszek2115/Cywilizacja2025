extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass
	# var value = GlobalState.slider_value # Load the value from the Global singleton
	# $Panel/GridContainer/Slider.value = value # Set the slider's value
	# AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), linear_to_db(value)) # Set the global volume level


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass




func _on_back_to_menu_button_pressed() -> void:
	get_tree().change_scene_to_file("res://main_menu/main_menu.tscn")
	


func _on_volume_slider_value_changed(value: float) -> void:
	pass
	# Set the global volume level based on the slider's value
	# AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), linear_to_db(value))
	# GlobalState.slider_value = value  # Store the value in the Global singleton
