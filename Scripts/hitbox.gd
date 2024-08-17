class_name Hitbox
extends Area3D

@export var damage = 10

func _init() -> void:
	#layers work on bit values, so layer 2 uses collision_layer 2, layer 3 uses 4, etc
	collision_layer = 2
	collision_mask = 0
