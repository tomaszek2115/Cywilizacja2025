extends Node

@onready var button_save: Button = $"../CanvasLayer/button_save"
@onready var button_exit: Button = $"../CanvasLayer/button_exit"
@onready var saver_loader: SaverLoader = %SaverLoader
@onready var board: Sprite2D = $".."
@onready var score_label: RichTextLabel = $"../CanvasLayer/score_label"
@onready var budget_player_1: RichTextLabel = $"../CanvasLayer/budget_player1"
@onready var budget_player_2: RichTextLabel = $"../CanvasLayer/budget_player2"
@onready var pause_label: Label = $"../CanvasLayer/pause_label"
@onready var saving_layer: CanvasLayer = $"../SavingLayer"
@onready var canvas_layer: CanvasLayer = $"../CanvasLayer"


func _ready() -> void:
	button_save.visible = false
	button_exit.visible = false
	pause_label.visible = false

#a2a2a2

func _on_button_pause_pressed() -> void:
	if !button_save.visible:
		button_save.visible = true
		button_exit.visible = true
		pause_label.visible = true
		score_label.visible = false
		budget_player_1.visible = false
		budget_player_2.visible = false
		board.modulate = Color("#a2a2a2")
		board.shop.hide()
		GlobalState.is_shop_open = false

	else:
		button_save.visible = false
		button_exit.visible = false
		pause_label.visible = false
		score_label.visible = true
		budget_player_1.visible = true
		budget_player_2.visible = true
		board.modulate = Color("ffffff")

func _on_button_exit_pressed() -> void:
	get_tree().change_scene_to_file("res://main_menu/main_menu.tscn")

func _on_button_save_pressed() -> void:
	canvas_layer.hide()
	saving_layer.show()
