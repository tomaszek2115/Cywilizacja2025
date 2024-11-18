extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_btn_new_game_pressed() -> void:
	get_tree().change_scene_to_file("res://new_game/new_game.tscn")
	print("New Game pressed")
	 # Replace with function body.

func _on_btn_load_game_pressed() -> void:
	print("Load Game pressed") # Replace with function body.

func _on_btn_settings_pressed() -> void:
	print("Settings pressed") # Replace with function body.
