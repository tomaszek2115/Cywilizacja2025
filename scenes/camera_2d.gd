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

#func _input(event):
	#if event is InputEventScreenTouch:
		#handle_touch(event)
	#elif event is InputEventScreenDrag:
		#handle_drag(event)
#
#func handle_touch(event):
	#if event.pressed:
		#touch_points[event.index] = event.position
	#else:
		#touch_points.erase(event.index)
	#
	#if touch_points.size() == 2:
		#var touch_point_positions = touch_points.values()
		#start_distance = touch_point_positions[0].distance_to(touch_point_positions)
		#start_zoom = zoom
	#elif touch_points.size() < 2:
		#start_distance = 0
#
#func handle_drag(event: InputEventScreenDrag):
	#touch_points[event.index] = event.position
	#
	#if touch_points.size() == 1:
		#if can_pan:
			#offset -= event.relative * pan_speed / zoom.x
	#
	#elif touch_points.size() == 2:
		#var touch_point_positions = touch_points.values()
		#var current_dist = touch_point_positions[0].distance_to(touch_point_positions[1])
		#
		#var zoom_factor = start_distance / current_dist
		#if can_zoom:
			#zoom = start_zoom / zoom_factor
		#limit_zoom(zoom)
#
#func limit_zoom(new_zoom):
	#if new_zoom.x < 0.1:
		#zoom.x = 0.1
	#if new_zoom.y < 0.1:
		#zoom.y = 0.1
	#if new_zoom.x > 10:
		#zoom.x = 10
	#if new_zoom.y > 10:
		#new_zoom.y = 10
