extends CharacterBody3D

#dictionaries are essentially hash maps
var load_data = {}
var count = 0

#func ready():
	#load_data = load_file()

func load_file():
	var file = FileAccess.open("user://kitty_data.json", FileAccess.READ)
	var json = JSON.new()
	var json_string = file.get_as_text()
	var error = json.parse(json_string)
	if error == OK:
		var data_received = json.data
		if typeof(data_received) == TYPE_ARRAY:
			print(data_received) # Prints array
		else:
			print("Unexpected data")
	else:
		print("JSON Parse Error: ", json.get_error_message(), " in ", json_string, " at line ", json.get_error_line())
	
	print(json_string)
	
	return json_string

func _physics_process(delta: float) -> void:
	if Input.is_action_just_released("debug"):
		load_data = load_file()
		print(load_data)
		#print(load_data.get(str(count+1)))
	get_recording()
	pass

func get_recording():
	count += 1 
	#grabs count entry in dictionary
	var test = load_data.get(str(count))
	#print(test)
	if(test != null):
		#sets values based on dictionary entry
		print(test[1])
		global_position = str_to_var("Vector3"+test[0])
		global_rotation = str_to_var("Vector3"+test[1])
