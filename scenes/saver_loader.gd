class_name SaverLoader

extends Node

@onready var board: Sprite2D = $".."
@onready var canvas_layer: CanvasLayer = $"../CanvasLayer"
@onready var saving_layer: CanvasLayer = $"../SavingLayer"

func save_game(slot: int):
	
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
	
	match slot:
		1:
			ResourceSaver.save(saved_game, "res://saves/save1.tres")
		2:
			ResourceSaver.save(saved_game, "res://saves/save2.tres")
		3:
			ResourceSaver.save(saved_game, "res://saves/save3.tres")
	print("game saved")

func load_game(slot: int):
	
	var saved_game:SavedGame
	
	match slot:
		1:
			saved_game = load("res://saves/save1.tres") as SavedGame
		2:
			saved_game = load("res://saves/save2.tres") as SavedGame
		3:
			saved_game = load("res://saves/save3.tres") as SavedGame
	
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

func _on_button_return_pressed() -> void:
	canvas_layer.show()
	saving_layer.hide()

func _on_button_save_1_pressed() -> void:
	save_game(1)

func _on_button_save_2_pressed() -> void:
	save_game(2)

func _on_button_save_3_pressed() -> void:
	save_game(3)
