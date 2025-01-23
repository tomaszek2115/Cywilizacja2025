class_name SaverLoader

extends Node

@onready var board: Sprite2D = $".."


func save_game():
	
	var saved_game:SavedGame = SavedGame.new()
	
	saved_game.board = board.board
	saved_game.blue = board.blue
	saved_game.state = board.state
	saved_game.moves = board.moves
	saved_game.selected_piece = board.selected_piece
	saved_game.ownership = board.ownership
	saved_game.item = board.item
	saved_game.shopping = board.shopping
	saved_game.selected_place = board.selected_place
	saved_game.budget_p1 = board.budget_p1
	saved_game.budget_p2 = board.budget_p2
	
	ResourceSaver.save(saved_game, "res://saves/savegame.tres")
	print("game saved")

func load_game():
	var saved_game:SavedGame = load("res://saves/savegame.tres") as SavedGame
	
	board.board = saved_game.board
	board.blue = saved_game.blue
	board.state = saved_game.state
	board.moves = saved_game.moves
	board.selected_piece = saved_game.selected_piece
	board.ownership = saved_game.ownership
	board.item = saved_game.item
	board.shopping = saved_game.shopping
	board.selected_place = saved_game.selected_place
	board.budget_p1 = saved_game.budget_p1
	board.budget_p2 = saved_game.budget_p2
