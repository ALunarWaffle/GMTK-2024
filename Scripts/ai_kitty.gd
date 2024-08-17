extends CharacterBody3D

@onready var ani = $AnimationPlayer

#dictionaries are essentially hash maps
var load_data = {}
var count = 0
var doReplay = false

#func ready():
	#load_data = load_file()

func load_file():
	var file = FileAccess.open("user://kitty_data.json", FileAccess.READ)
	var content = file.get_as_text()
	var output = JSON.parse_string(content)
	
	return output

func _physics_process(delta: float) -> void:
	if Input.is_action_just_released("debug"):
		begin_recording()
	if (doReplay == true):
		get_recording()
		
	pass

func begin_recording():
	load_data = load_file()
	doReplay = true

func get_recording():
	count += 1 
	#grabs count entry in dictionary
	var test = load_data.get(str(count))
	if(test != null):
		#sets values based on dictionary entry
		if (test[0] != null && test[0] != ""):
			ani.play(test[0])
		global_position = str_to_var("Vector3"+test[1])
		global_rotation = str_to_var("Vector3"+test[2])
