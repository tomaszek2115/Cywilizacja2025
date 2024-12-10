extends CanvasLayer

var currentItem = 0
var select = 0
var bought_item = 0

@onready var button1 = $Panel/unit_1
@onready var button2 = $Panel/unit_2
@onready var button3 = $Panel/unit_3
@onready var button4 = $Panel/city_1
@onready var button5 = $Panel/city_2
@onready var button6 = $Panel/city_3
@onready var panel = $Panel


func _on_unit_1_pressed() -> void:
	currentItem = 1
	buy(currentItem)

func _on_unit_2_pressed() -> void:
	currentItem = 2
	buy(currentItem)

func _on_unit_3_pressed() -> void:
	currentItem = 3
	buy(currentItem)

func _on_city_1_pressed() -> void:
	currentItem = 4
	buy(currentItem)

func _on_city_2_pressed() -> void:
	currentItem = 5
	buy(currentItem)

func _on_city_3_pressed() -> void:
	currentItem = 6
	buy(currentItem)
	
func buy(item):
	bought_item = item

func get_item() -> int:
	print("dos")
	print(bought_item)
	return bought_item

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
