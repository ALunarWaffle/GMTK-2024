extends Control

@onready var timer = $Timer
@onready var label = $Label

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	timer.start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	label.text = "%s" % snapped(timer.time_left, 1)
