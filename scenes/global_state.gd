extends Node

var current_item : int = 0
var slider_value : float = 0.5  # Default to 50% volume (value can be between 0.0 and 1.0)
var value : int = 0
var is_shop_open: bool = false
var is_loaded: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func reset_globals():
	GlobalState.current_item = 0
	GlobalState.is_shop_open = false
	GlobalState.value = 0
