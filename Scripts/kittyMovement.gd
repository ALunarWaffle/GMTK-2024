extends CharacterBody3D

@onready var mesh = $KittyMesh

@export var SPEED = 7.0
@export var JUMP_VELOCITY = 8
@export var gravity = 20

var count = 0

# data recorded in hash map, has being frame of action ("0") 
#"nothing" = animation, first Vector3 = position, second Vector3 = rotation
var save_data = {"0": [Vector3(0,0,0),Vector3(0,0,0)]}

#mouse focus on game in desktop copy
func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

#mouse focus on game in browser copy (when clicking on game
func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _physics_process(delta: float) -> void:
	record_actions()
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir := Input.get_vector("left", "right", "up", "down")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		#rotates rendered character so they're pointing based on player input
		#pi/2 added because input_dir works on an x/y 2d plane that's 90 deg off from x/z 3d plane
		#similarly, 3d plane I think rotates differently, thus the negatives
		mesh.rotation.y = -(input_dir.angle()-(PI/2))
		
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)
	
	if Input.is_action_just_pressed("debug"):
		print("Saving movements...")
		save_to_file(save_data)

	move_and_slide()

#Every physics frame, animation, position, and rotation are recorded into hash
func record_actions():
	count += 1
	#writes to library 
	save_data[str(count)] = [global_position,global_rotation]

func save_to_file(content):
	#writes to user://, which will store in cache for html
	var file = FileAccess.open("user://kitty_data.json", FileAccess.WRITE)
	file.store_string(JSON.stringify(content))
