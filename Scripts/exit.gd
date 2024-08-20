extends AnimatableBody3D

@onready var area = $Area3D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass



func _on_area_3d_body_entered(body):
	if body != null and body == get_node("../MouseBody3D"):
		var scoreBoard = get_node("../MouseBody3D/ScoreTracker")
		scoreBoard.save_score()
		get_tree().change_scene_to_file("res://Scenes/win_screen.tscn")
