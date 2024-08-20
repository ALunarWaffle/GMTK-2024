extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_start_pressed() -> void:
	$Click.play()
	$TextureRect3.set_visible(true)
	$Start2.set_visible(true)
	$VBoxContainer.set_visible(false)
	#get_tree().change_scene_to_file("res://Scenes/kitty_playmat.tscn")


func _on_quit_pressed() -> void:
	$Click.play()
	$TextureRect5.set_visible(true)
	$Start5.set_visible(true)
	$VBoxContainer.set_visible(false)


func _on_start_2_pressed() -> void:
	$Click.play()
	$TextureRect3.set_visible(false)
	$TextureRect2.set_visible(true)
	$Start2.set_visible(false)
	$Start3.set_visible(true)


func _on_start_3_pressed() -> void:
	$Click.play()
	$TextureRect2.set_visible(false)
	$TextureRect.set_visible(true)
	$Start3.set_visible(false)
	$Start4.set_visible(true)


func _on_start_4_pressed() -> void:
	$Click.play()
	get_tree().change_scene_to_file("res://Scenes/kitty_playmat.tscn")


func _on_start_5_pressed() -> void:
	$Click.play()
	$TextureRect5.set_visible(false)
	$Start5.set_visible(false)
	$VBoxContainer.set_visible(true)
