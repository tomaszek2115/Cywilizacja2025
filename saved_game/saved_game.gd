class_name SavedGame
extends Resource

#@export var board : Array
#@export var blue : bool
#@export var ownership : Array
#@export var budget_p1: int
#@export var budget_p2: int

@export var board : Array
@export var blue : bool = true #white w szachach also w tym tutorialu i zaczyna
@export var state : bool = false #brother said just in case :sob:
@export var moves = []
@export var selected_piece : Vector2
@export var ownership : Array
@export var item: int
@export var shopping: bool
@export var selected_place: Vector2
@export var budget_p1: int
@export var budget_p2: int
