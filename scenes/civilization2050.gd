extends Sprite2D

const MAP_WIDTH = 12
const MAP_HEIGHT = 6
const CELL_WIDTH = 80

const TEXTURE_HOLDER = preload("res://scenes/texture_holder.tscn")

const PORTRAIT_KAMIL = preload("res://assets/portrait_kamil.png")
const PORTRAIT_OLA = preload("res://assets/portrait_ola.png")
const PORTRAIT_TOMEK = preload("res://assets/portrait_ola.png")
const PORTRAIT_ZUZIA = preload("res://assets/portrait_zuzia.png")

const UNITS_BLUE_1 = preload("res://assets/units_blue_1.png")
const UNITS_BLUE_2 = preload("res://assets/units_blue_2.png")
const UNITS_BLUE_3 = preload("res://assets/units_blue_3.png")
const UNITS_RED_1 = preload("res://assets/units_red_1.png")
const UNITS_RED_2 = preload("res://assets/units_red_2.png")
const UNITS_RED_3 = preload("res://assets/units_red_3.png")
const CITY_1 = preload("res://assets/city1.png")
const CITY_2 = preload("res://assets/city2.png")
const CITY_3 = preload("res://assets/city3.png")
const CAPITAL = preload("res://assets/capital.png")

const TURN_BLUE = preload("res://assets/turn_blue.png")
const TURN_RED = preload("res://assets/turn_red.png")

const PIECE_MOVE = preload("res://assets/piece_move.png")

@onready var characters = $characters
@onready var turn = $turn
@onready var dots = $dots
@onready var score_label = $score_label
@onready var shop = $shop_panel


#Variables
var board : Array
var blue : bool = true #white w szachach also w tym tutorialu i zaczyna
var state : bool = false #brother said just in case :sob:
var moves = []
var selected_piece : Vector2
var ownership : Array = []
var item: int = 0
var shopping: bool = true
var is_shop_open: bool = false
var selected_place: Vector2 = Vector2(-1, -1)

# Called when the node enters the scene tree for the first time.
func _ready() -> void: #ładuje od dołu do góry tak uzupełnia to gówno
	shop.hide()
	
	board.append([0,0,0,0,0,0,0,0,0,0,0,0])
	board.append([0,3,0,0,0,0,0,0,0,0,7,0])	
	board.append([0,2,0,0,0,0,0,0,0,0,-3,0]) #+ is blue
	board.append([0,1,0,0,0,0,0,0,0,0,-2,0]) #- is red 
	board.append([0,7,0,0,0,0,0,0,0,0,-1,0])
	board.append([0,0,0,0,0,0,0,0,0,0,0,0])
	
	# stworz tabele ownership
	for i in range(MAP_HEIGHT):
		var row = []
		for j in range(MAP_WIDTH):
			row.append(0)
		ownership.append(row)
		
	display_board()

func _process(delta: float) -> void:
	check_purchase()

func _input(event):
	if event is InputEventMouseButton && event.pressed:
		if event.button_index == MOUSE_BUTTON_LEFT:
			if is_mouse_out(): 
				close_shop()
				return
			var var1 = snapped(get_global_mouse_position().x, 0) / CELL_WIDTH
			var var2 = abs(snapped(get_global_mouse_position().y, 0)) / CELL_WIDTH
			#print(var1, ",", var2)
			
			# logika zakupów
			if is_shop_open:
					if not shop.get_global_rect().has_point(get_global_mouse_position()):
						close_shop()
					return
			
			if shopping && board[var2][var1] == 0:
				open_shop()
				#item = GlobalState.current_item
				item = 0
				selected_place = Vector2(var2, var1)
				return
			
			# logika poruszania sie
			if !state && ((blue && board[var2][var1] == 1) || (!blue && board[var2][var1] == -1) || (blue && board[var2][var1] == 2) || (blue && board[var2][var1] == 3) || (blue && board[var2][var1] == 4) || (!blue && board[var2][var1] == -2) || (!blue && board[var2][var1] == -3) || (!blue && board[var2][var1] == -4)):
				selected_piece = Vector2(var2, var1)
				show_options()
				state = true
				shopping = false
				
			elif state: 
				set_move(var2, var1)
				shopping = true
				
			
func is_mouse_out():
	if get_global_mouse_position().x < 0 || get_global_mouse_position().x > 960 || get_global_mouse_position().y > 0 || get_global_mouse_position().y < -480: return true
	return false

func display_board():
	for child in characters.get_children():
		child.queue_free()

	for i in MAP_HEIGHT:
		for j in MAP_WIDTH:
			var holder = TEXTURE_HOLDER.instantiate()
			characters.add_child(holder)
			holder.global_position = Vector2(j * CELL_WIDTH + (CELL_WIDTH / 2), -i * CELL_WIDTH - (CELL_WIDTH / 2))
			
			match board[i][j]:
				-1: holder.texture = UNITS_RED_1
				-2: holder.texture = UNITS_RED_2
				-3: holder.texture = UNITS_RED_3
				-4: holder.texture = CITY_1
				-5: holder.texture = CITY_2
				-6: holder.texture = CITY_3
				-7: holder.texture = CAPITAL
				0: holder.texture = null
				1: holder.texture = UNITS_BLUE_1
				2: holder.texture = UNITS_BLUE_2
				3: holder.texture = UNITS_BLUE_3
				4: holder.texture = CITY_1
				5: holder.texture = CITY_2
				6: holder.texture = CITY_3
				7: holder.texture = CAPITAL
				
	if blue: turn.texture = TURN_BLUE
	else: turn.texture = TURN_RED #to jest tylko tymczasowe bo idk jeszcze sie to ustawi jakos inaczej pewnie

func show_options():
	moves = get_moves()
	if moves == []:
		print("0 moves")
		state = false
		return
	show_dots()
	
func show_dots():
	for i in moves:
		var holder = TEXTURE_HOLDER.instantiate()
		dots.add_child(holder)
		holder.texture = PIECE_MOVE
		holder.global_position = Vector2(i.y * CELL_WIDTH + (CELL_WIDTH/2), -i.x * CELL_WIDTH - (CELL_WIDTH/2))

func delete_dots():
	for child in dots.get_children():
		child.queue_free()

func set_move(var2, var1):
	for i in moves:
		if i.x == var2 && i.y == var1:
			
			board[var2][var1] = board[selected_piece.x][selected_piece.y]
			board[selected_piece.x][selected_piece.y] = 0
			
			# update ownership
			if blue:
				ownership[var2][var1] = 1 # blue captures
			else:
				ownership[var2][var1] = -1 # red captures
					
			blue = !blue
			display_board()
			
			# update the score display
			update_score_display()
			break
	delete_dots()
	state = false

func calculate_score():
	var blue_count = 0
	var red_count = 0
	var total_cells = MAP_WIDTH * MAP_HEIGHT
	
	for row in ownership:
		for cell in row:
			if cell == 1:
				blue_count +=1
			elif cell == -1:
				red_count +=1
	
	var blue_percentage = float (blue_count) / total_cells * 100
	var red_percentage = float(red_count) / total_cells * 100
	
	return [blue_percentage, red_percentage]
	
func update_score_display():
	var scores = calculate_score()
	var blue_percentage = scores[0]
	var red_percentage = scores[1]
	
	#check for win condition
	if blue_percentage == 100:
		score_label.bbcode_text = "[center][color=blue]GOOD GAME\nBLUE WINS![/color][/center]"
		disable_gameplay() # stop further actions
		return
	elif red_percentage == 100:
		score_label.bbcode_text = "[center][color=red]GOOD GAME!\nRED WINS![/color][/center]"
		disable_gameplay()  # stop further actions
	
	# determine turn text based on which player's turn it is
	var turn_text = "BLUE TURN" if blue else "RED TURN"
	var turn_color = "[color=blue]" if blue else "[color=red]"
	
	# format the text for the label
	var formatted_text = "[center]"
	formatted_text += "[color=blue]" + str(round(blue_percentage)) + "%[/color]  "
	formatted_text += turn_color + turn_text + "[/color]  "
	formatted_text += "[color=red]" + str(round(red_percentage)) + "%[/color]"
	formatted_text += "[/center]"
	score_label.bbcode_text = formatted_text
	

# Function to stop the gameplay
func disable_gameplay():
	# prevent further interactions in the game
	set_process_input(false)
	turn.texture = null
	



func get_moves():
	var _moves = []
	match abs(board[selected_piece.x][selected_piece.y]):
		1: _moves = get_basic_moves()
		2: _moves = get_basic_moves()
		3: _moves = get_basic_moves()
	return _moves

func is_valid_position(pos : Vector2):
	if pos.x >= 0 && pos.x < MAP_HEIGHT && pos.y >= 0 && pos.y < MAP_WIDTH: return true
	return false
	
func is_empty(pos : Vector2):
	if board[pos.x][pos.y] == 0: return true
	return false
	#if blue (white) turn blue=true: enemy index is negative
	#if red (black) turn blue=false: enemy index is positive
func is_enemy(pos : Vector2):
	if blue && board[pos.x][pos.y] < 0 || !blue && board[pos.x][pos.y] > 0: return true
	return false
	
func is_stronger(pos : Vector2):
	if is_valid_position(pos) and is_enemy(pos): 
		var selected_strength = abs(board[selected_piece.x][selected_piece.y]) 
		var enemy_strength = abs(board[pos.x][pos.y]) 
		return enemy_strength > selected_strength
	return false
	
	
func get_basic_moves():
	var _moves = []
	var directions = [Vector2(0,1), Vector2(0,-1), Vector2(1,0), Vector2(-1,0), 
					  Vector2(1,1), Vector2(1,-1), Vector2(-1,1), Vector2(-1,-1)]
	for i in directions:
		var pos = selected_piece + i
		if is_valid_position(pos):
			if is_empty(pos): _moves.append(pos)
			elif is_enemy(pos) and not is_stronger(pos):
				_moves.append(pos)
	return _moves

func open_shop():
	shop.show()
	is_shop_open = true

func close_shop():
	shop.hide()
	is_shop_open = false

func check_purchase():
	if GlobalState.current_item != 0 and selected_place != Vector2(-1, -1):
		# umieść jednostkę na planszy
		if blue: board[selected_place.x][selected_place.y] = GlobalState.current_item
		else: board[selected_place.x][selected_place.y] = -GlobalState.current_item
		
		# resetuj wybór
		GlobalState.current_item = 0
		selected_place = Vector2(-1, -1)
		display_board()
		close_shop()
