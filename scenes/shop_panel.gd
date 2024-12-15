extends Panel

func _on_button_units_1_pressed() -> void:
	GlobalState.current_item = 1

func _on_button_units_2_pressed() -> void:
	GlobalState.current_item = 2

func _on_button_units_3_pressed() -> void:
	GlobalState.current_item = 3

func _on_button_city_1_pressed() -> void:
	GlobalState.current_item = 4

func _on_button_city_2_pressed() -> void:
	GlobalState.current_item = 5

func _on_button_city_3_pressed() -> void:
	GlobalState.current_item = 6




# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
