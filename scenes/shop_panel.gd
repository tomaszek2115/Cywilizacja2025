extends Panel

func _on_button_units_1_pressed() -> void:
	GlobalState.current_item = 1
	GlobalState.value = 100

func _on_button_units_2_pressed() -> void:
	GlobalState.current_item = 2
	GlobalState.value = 150

func _on_button_units_3_pressed() -> void:
	GlobalState.current_item = 3
	GlobalState.value = 200

func _on_button_city_1_pressed() -> void:
	GlobalState.current_item = 4
	GlobalState.value = 100

func _on_button_city_2_pressed() -> void:
	GlobalState.current_item = 5
	GlobalState.value = 175

func _on_button_city_3_pressed() -> void:
	GlobalState.current_item = 6
	GlobalState.value = 250




# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
