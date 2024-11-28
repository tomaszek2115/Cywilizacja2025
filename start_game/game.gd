extends Node2D

var game_finished = false

func _ready():
	if GlobalVariables.isGeneratingNeeded == true:
		print("generating...")
	else:
		print("loading game...")
