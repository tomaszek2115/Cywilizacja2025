extends Camera2D

@export var zoom_speed : float = 0.1
@export var pan_speed: float = 1.0

@export var can_pan: bool
@export var can_zoom: bool

var touch_points: Dictionary = {}
var start_distance
var start_zoom

var zoomTarget : Vector2

var dragStartMousePos = Vector2.ZERO
var dragStartCameraPos = Vector2.ZERO
var isDragging : bool = false

func _ready() -> void:
	zoomTarget = zoom

func _process(delta: float) -> void:
	Zoom(delta)
	ClickAndDrag()

func Zoom(delta):
	if Input.is_action_just_pressed("camera_zoom_in"):
		zoomTarget *= 1.1
		print(zoomTarget)
	
	if Input.is_action_just_pressed("camera_zoom_out"):
		zoomTarget *= 0.9
		print(zoomTarget)
	
	zoom = zoom.slerp(zoomTarget, zoom_speed * delta)

func ClickAndDrag():
	if !isDragging and Input.is_action_just_pressed("click"):
		dragStartMousePos = get_viewport().get_mouse_position()
		dragStartCameraPos = position
		isDragging = true
	
	if isDragging and Input.is_action_just_released("click"):
		isDragging = false
	
	if isDragging:
		var moveVector = get_viewport().get_mouse_position() - dragStartMousePos
		position = dragStartCameraPos - moveVector * 3/zoom.x
