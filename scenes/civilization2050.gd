extends Sprite2D

const MAP_WIDTH = 12
const MAP_HEIGHT = 6
const CELL_WIDTH = 80

const TEXTURE_HOLDER = preload("res://scenes/texture_holder.tscn")

const PORTRAIT_KAMIL = preload("res://assets/portrait_kamil.png")
const PORTRAIT_OLA = preload("res://assets/portrait_ola.png")
const PORTRAIT_TOMEK = preload("res://assets/portrait_ola.png")
const PORTRAIT_ZUZIA = preload("res://assets/portrait_zuzia.png")

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
	board.append([0,0,0,0,0,0,0,0,0,0,0,0])	
	board.append([0,1,0,0,0,0,0,0,0,0,0,0]) #1 is main character blue (zuzia)
	board.append([0,0,0,0,0,0,0,0,0,0,-1,0]) #-1 is main character red (kamil) 
	board.append([0,0,0,0,0,0,0,0,0,0,0,0])
	board.append([0,0,0,0,0,0,0,0,0,0,0,0])
	
	display_board()
	
func _input(event):
	if event is InputEventMouseButton && event.pressed:
		if event.button_index == MOUSE_BUTTON_LEFT:
			if is_mouse_out(): return
			var var1 = snapped(get_global_mouse_position().x, 0) / CELL_WIDTH
			var var2 = abs(snapped(get_global_mouse_position().y, 0)) / CELL_WIDTH
			print(var1, ",", var2)
			if !state && (blue && board[var2][var1] > 0 || !blue && board[var2][var1] < 0):
				selected_piece = Vector2(var2, var1)
				show_options()
				state = true
			
func is_mouse_out():
	if get_global_mouse_position().x < 0 || get_global_mouse_position().x > 960 || get_global_mouse_position().y > 0 || get_global_mouse_position().y < -480: return true
	return false

func display_board():
	for i in MAP_HEIGHT:
		for j in MAP_WIDTH:
			var holder = TEXTURE_HOLDER.instantiate()
			characters.add_child(holder)
			@warning_ignore("integer_division")
			holder.global_position = Vector2(j*CELL_WIDTH + (CELL_WIDTH/2), -i*CELL_WIDTH - (CELL_WIDTH/2))
			
			match board[i][j]:
				-1: holder.texture = PORTRAIT_KAMIL
				0: holder.texture = null
				1: holder.texture = PORTRAIT_ZUZIA
				
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
	
func get_moves():
	var _moves = []
	match abs(board[selected_piece.x][selected_piece.y]):
		#-1: _moves = get_basic_moves()
		1: _moves = get_basic_moves()
		2: print("warrior type 1")
		3: print("warrior type 2")
		4: print("warrior type 3")
	return _moves

func is_valid_position(pos : Vector2):
	if pos.x >= 0 && pos.x < MAP_WIDTH && pos.y >= 0 && pos.y < MAP_HEIGHT: return true
	return false
	
func is_empty(pos : Vector2):
	if board[pos.x][pos.y] == 0: return true
	return false
	#if blue (white) turn blue=true: enemy index is negative
	#if red (black) turn blue=false: enemy index is positive
func is_enemy(pos : Vector2):
	if blue && board[pos.x][pos.y] < 0 || !blue && board[pos.x][pos.y] > 0: return true
	return false
	
func get_basic_moves():
	var _moves = []
	var directions = [Vector2(0,1), Vector2(0,-1), Vector2(1,0), Vector2(-1,0), 
					  Vector2(1,1), Vector2(1,-1), Vector2(-1,1), Vector2(-1,-1)]
	for i in directions:
		var pos = selected_piece + i
		if is_valid_position(pos):
			if is_empty(pos): _moves.append(pos)
			elif is_enemy(pos):
				_moves.append(pos)
	return _moves
