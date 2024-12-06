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

const TURN_BLUE = preload("res://assets/turn_blue.png")
const TURN_RED = preload("res://assets/turn_red.png")

const PIECE_MOVE = preload("res://assets/piece_move.png")

@onready var characters = $characters
@onready var turn = $turn
@onready var dots = $dots

#Variables
var board : Array
var blue : bool = true #white w szachach also w tym tutorialu i zaczyna
var state : bool = false #brother said just in case :sob:
var moves = []
var selected_piece : Vector2

# Called when the node enters the scene tree for the first time.
func _ready() -> void: #ładuje od dołu do góry tak uzupełnia to gówno
	board.append([0,0,0,0,0,0,0,0,0,0,0,0])
	board.append([0,3,0,0,0,0,0,0,0,0,-4,0])	
	board.append([0,2,0,0,0,0,0,0,0,0,-3,0]) #4 is main character blue (zuzia)
	board.append([0,1,0,0,0,0,0,0,0,0,-2,0]) #-4 is main character red (kamil) 
	board.append([0,4,0,0,0,0,0,0,0,0,-1,0])
	board.append([0,0,0,0,0,0,0,0,0,0,0,0])
	
	display_board()
	
func _input(event):
	if event is InputEventMouseButton && event.pressed:
		if event.button_index == MOUSE_BUTTON_LEFT:
			if is_mouse_out(): return
			var var1 = snapped(get_global_mouse_position().x, 0) / CELL_WIDTH
			var var2 = abs(snapped(get_global_mouse_position().y, 0)) / CELL_WIDTH
			#print(var1, ",", var2)
			if !state && ((blue && board[var2][var1] == 1) || (!blue && board[var2][var1] == -1) || (blue && board[var2][var1] == 2) || (blue && board[var2][var1] == 3) || (blue && board[var2][var1] == 4) || (!blue && board[var2][var1] == -2) || (!blue && board[var2][var1] == -3) || (!blue && board[var2][var1] == -4)):
				selected_piece = Vector2(var2, var1)
				show_options()
				state = true
			elif state: set_move(var2, var1)
			
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
				-4: holder.texture = PORTRAIT_KAMIL
				0: holder.texture = null
				1: holder.texture = UNITS_BLUE_1
				2: holder.texture = UNITS_BLUE_2
				3: holder.texture = UNITS_BLUE_3
				4: holder.texture = PORTRAIT_ZUZIA
				
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
			blue = !blue
			display_board()
			break
	delete_dots()
	state = false

func get_moves():
	var _moves = []
	match abs(board[selected_piece.x][selected_piece.y]):
		1: _moves = get_basic_moves()
		2: _moves = get_basic_moves()
		3: _moves = get_basic_moves()
		4: _moves = get_basic_moves() #postacie
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
