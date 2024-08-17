extends AnimatableBody3D

@onready var ani = $AnimationPlayer

@export var health = 1
@export var minDamage = 1

func take_damage(damage):
	if (damage >= minDamage):
		health -= damage
		if (health <= 0):
			ani.play("temp_crumble")
