extends Control

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	pass

func _on_back_to_menu_button_pressed() -> void:
	get_tree().change_scene_to_file("res://main_menu/main_menu.tscn")

func _on_tutorial_button_pressed() -> void:
	get_tree().change_scene_to_file("res://settings/policy.tscn")

func _on_privacy_button_pressed() -> void:
	get_tree().change_scene_to_file("res://settings/tutorial.tscn")
