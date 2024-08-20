extends CharacterBody3D

@onready var mesh = $Body
@onready var ani = $AnimationPlayer
@onready var tracker = get_node("../ScoreTracker")

@export var SPEED = 7.0
@export var JUMP_VELOCITY = 8
@export var gravity = 20

var count = 0
var doRecord = false

# data recorded in hash map, has being frame of action ("0") 
#"nothing" = animation, first Vector3 = position, second Vector3 = rotation
var save_data = {"0": ["nothing",Vector3(0,0,0),Vector3(0,0,0)]}

#mouse focus on game in desktop copy
func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	start_recording()

#mouse focus on game in browser copy (when clicking on game
func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _physics_process(delta: float) -> void:
	#record cat movements
	if (doRecord == true):
		record_actions()

	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	if Input.is_action_just_pressed("attack"):
		ani.play("swipe")
		ani.queue("RESET")

	# Get the input direction and handle the movement/deceleration.
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
		stop_recording()
		get_tree().change_scene_to_file("res://Scenes/mouse_playmat.tscn")

	#stops character from sticking to walls while walking into them
	move_and_slide()

func start_recording():
	doRecord = true

func stop_recording():
	doRecord = false
	save_to_file(save_data)

#Every physics frame, animation, position, and rotation are recorded into hash
func record_actions():
	count += 1
	#writes to library
	#rotation is off due to rotating model for temp mesh, will have to adjust with real model 
	#(likely as simple as removing +Vector3 entirely 
	save_data[str(count)] = [ani.current_animation, global_position,mesh.rotation+Vector3(-PI/2,(3*PI)/2,0)]

func save_to_file(content):
	#writes to user://, which will store in cache for html
	var file = FileAccess.open("user://kitty_data.json", FileAccess.WRITE)
	file.store_string(JSON.stringify(content))


func _on_area_3d_area_entered(area: Area3D) -> void:
	print(area.get_collision_layer())
	if (area.get_collision_layer() == 9):
		var cheese = area.get_node("..")
		cheese.queue_free()
		tracker.update_score(1000)
