extends Node

class_name TurnQueue

var active_unit

func initialize():
	active_unit = get_child(0)

func play_turn():
	await active_unit.play_turn
	var new_index : int = (active_unit.get_index() + 1) % get_child_count()
	active_unit = get_child(new_index)
