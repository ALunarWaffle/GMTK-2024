extends AnimatableBody3D

#@onready var ani = $AnimationPlayer
@onready var shell = $Mesh

@export var health = 10
@export var minDamage = 5
@export var value = 10
@onready var tracker = get_node("../../../ScoreTracker")


func take_damage(damage):
	if (damage >= minDamage):
		health -= damage
		#print(health)
		if (health <= 0):
			if shell!=null and shell.has_method("destroy"):
				if tracker != null and tracker.has_method("update_score"):
					tracker.update_score(value)
				#print("DESTROYING")
				shell.destroy()
			#ani.play("temp_crumble")
