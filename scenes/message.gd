extends Label

@onready var message_timer = $Timer

func _ready():
	# Ensure the label is hidden at the start
	self.visible = false
	# Use Callable for connecting the signal
	message_timer.timeout.connect(_on_message_timer_timeout)

# Function to display a message
func display_message(text: String, duration: float = 2.0):
	self.text = text
	self.visible = true
	message_timer.wait_time = duration
	message_timer.start()

# Callback when the timer finishes
func _on_message_timer_timeout():
	self.visible = false
