extends Node3D

@onready var kitty = $KittyBody3D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass



func _on_timer_timeout() -> void:
	kitty.stop_recording()
	$ScoreTracker.save_score()
	get_tree().change_scene_to_file("res://Scenes/mouse_playmat.tscn")
