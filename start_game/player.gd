extends Sprite2D

var is_player_selected = false

@onready var tile_map: TileMap = $".."

func _ready():
	modulate = Color(1, 1, 1)

func _input(event):
	if event is InputEventMouseButton and event.pressed:
		# Check if the player sprite was clicked
		if get_rect().has_point(to_local(event.position)):
			# Toggle selection state
			is_player_selected = !is_player_selected
			highlight_player(is_player_selected)

func move(direction: Vector2):
	var target_tile = direction

func highlight_player(selected: bool):
	if selected:
		modulate = Color(1, 1, 0)  # Highlight with yellow
	else:
		modulate = Color(1, 1, 1)  # Default color
