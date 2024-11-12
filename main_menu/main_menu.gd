extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_newGame_pressed() -> void:
	print("New Game pressed")
	#get_tree().change_scene_to_file()

func _on_loadGame_pressed() -> void:
	print("Load Game pressed")

func _on_settings_pressed() -> void:
	get_tree().quit() #potem sie doda reszte
