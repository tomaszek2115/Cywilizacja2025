extends Camera2D

@export var zoomSpeed : float = 10

var zoomTarget : Vector2
var dragStartCameraPos = Vector2.ZERO
var dragStartMousePos = Vector2.ZERO
var isDragging : bool = false

func _ready():
	zoomTarget = zoom

func _process(delta: float):
	Zoom(delta)
	ClickAndDrag()

func Zoom(delta):
	if Input.is_action_just_pressed("camera_zoom_in"):
		zoomTarget *= 1.1
	if Input.is_action_just_pressed("camera_zoom_out"):
		zoomTarget *= 0.9
	zoom = zoom.slerp(zoomTarget, zoomSpeed * delta)

func ClickAndDrag():
	if !isDragging and Input.is_action_just_pressed("camera_pan"):
		dragStartMousePos = get_viewport().get_mouse_position()
		dragStartCameraPos = position
		isDragging = true
	if isDragging and Input.is_action_just_released("camera_pan"):
		isDragging = false
	if isDragging:
		var moveVector = get_viewport().get_mouse_position() - dragStartMousePos
		position = dragStartCameraPos - moveVector * 1/zoom.x
