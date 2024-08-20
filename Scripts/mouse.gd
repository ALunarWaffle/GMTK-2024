extends CharacterBody3D


@export var SPEED = 5.0
@export var JUMP_VELOCITY = 4.5
@export var gravity = 20
@export var hp = 1

#mouse focus on game in desktop copy
func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

#mouse focus on game in browser copy (when clicking on game
func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

@onready var camroot = $Swivel
@onready var mesh = $Mouse

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta

	# Handle Jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	#inputs are defined in Project->Project Settings->Input Map
	var input_dir = Input.get_vector("left", "right", "up", "down")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	
	#rotates character controller to follow y of camera
	direction = direction.rotated(Vector3.UP,camroot.rotation.y).normalized()
	
	if direction:
		#rotates rendered character so they're pointing based on player input
		#pi/2 added because input_dir works on an x/y 2d plane that's 90 deg off from x/z 3d plane
		#similarly, 3d plane I think rotates differently, thus the negatives
		mesh.rotation.y = -(input_dir.angle()+(PI)-camroot.rotation.y)
		
		#moves character smoothly based on direction(s) input
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:		
		velocity.x = 0
		velocity.z = 0
	
	#to prevent sticking to terrain
	move_and_slide()

func take_damage(damage):
	hp -= damage
	if (hp <=0):
		death()

func death():
	pass
