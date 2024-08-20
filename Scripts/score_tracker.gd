extends Control

@export var score = 0
@onready var label = $Label
# Called when the node enters the scene tree for the first time.
func _ready():
	label.text = "Score: %s" % score


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func update_score(value):
	score += value
	label.text = "Score: %s" % score

func save_score():
	var file = FileAccess.open("user://current_score.json", FileAccess.WRITE)
	file.store_string(JSON.stringify(score))

func load_score():
	var file = FileAccess.open("user://current_score.json", FileAccess.READ)
	var content = file.get_as_text()
	update_score(str_to_var(content))
