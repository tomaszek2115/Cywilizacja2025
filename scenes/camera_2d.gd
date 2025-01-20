extends Camera2D

@export var zoomSpeed : float = 10

var zoomTarget : Vector2

var dragStartMousePos = Vector2.ZERO
var dragStartCameraPos = Vector2.ZERO
var isDragging : bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	zoomTarget = zoom


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	Zoom(delta)
	ClickAndDrag()

func Zoom(delta):
	if Input.is_action_just_pressed("camera_zoom_in") && zoomTarget < Vector2(2.85, 2.85):
		zoomTarget *= 1.1
		print(zoomTarget)
	
	if Input.is_action_just_pressed("camera_zoom_out") && zoomTarget > Vector2(1.0, 1.0):
		zoomTarget *= 0.9
		print(zoomTarget)
	
	zoom = zoom.slerp(zoomTarget, zoomSpeed * delta)

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
