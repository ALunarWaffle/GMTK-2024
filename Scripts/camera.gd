extends Node3D

@export var sensitivity = 0.002

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _unhandled_input(event):
	#turns mouse movement into camera movement
	if event is InputEventMouseMotion:
		rotation.y = rotation.y - event.relative.x * sensitivity
		rotation.x = rotation.x - event.relative.y * sensitivity
		#stops player from wrapping camera too far up/down
		rotation.x = clamp(rotation.x, deg_to_rad(-10), deg_to_rad(55))
		
