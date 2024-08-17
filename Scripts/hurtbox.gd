class_name Hurtbox
extends Area3D

func _init() -> void:
	#layers work on bit values, so layer 2 uses collision_layer 2, layer 3 uses 4, etc
	collision_layer = 0
	collision_mask = 2

func _ready() -> void:
	connect("area_entered", self._on_area_entered)

func _on_area_entered(hitbox: Hitbox) -> void:
	if hitbox == null:
		return
	
	#owner is parent of scene object
	if owner.has_method("take_damage"):
		owner.take_damage(hitbox.damage)
