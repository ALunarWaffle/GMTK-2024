extends CharacterBody3D

var gravity = 8

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _physics_process(delta):
	#print("Test")
	if not is_on_floor():
		#print("Testing")
		velocity.y -= gravity * delta
		
	move_and_slide()
