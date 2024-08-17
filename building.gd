extends AnimatableBody3D

#@onready var ani = $AnimationPlayer
@onready var shell = $CollisionShape3D/Shell

@export var health = 1
@export var minDamage = 1

func take_damage(damage):
	if (damage >= minDamage):
		health -= damage
		if (health <= 0):
			if shell!=null and shell.has_method("destroy"):
				shell.destroy()
			#ani.play("temp_crumble")
