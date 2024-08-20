extends Control

@onready var scoreTracker = $ScoreTracker
var score = 0
@onready var text = $BoxContainer/RichTextLabel

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	scoreTracker.load_score()
	score = scoreTracker.score
	text.text = "Final score: %s" % score
	
	if (score >= 40000):
		$A.set_visible(true)
	elif (score >= 30000):
		$B.set_visible(true)
	elif (score >= 20000):
		$C.set_visible(true)
	else:
		$F.set_visible(true)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_quit_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/title.tscn")
