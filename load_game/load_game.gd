extends Control

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
@warning_ignore("unused_parameter")
func _process(delta: float) -> void:
	pass

func _on_back_button_pressed() -> void:
	get_tree().change_scene_to_file("res://main_menu/main_menu.tscn")


func _on_settings_button_pressed() -> void:
	get_tree().change_scene_to_file("res://settings/Settings.tscn")
