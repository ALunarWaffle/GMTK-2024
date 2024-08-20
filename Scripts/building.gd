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
				if (tracker != null and tracker.has_method("update_score") and value !=0):
					tracker.update_score(value)
				#print("DESTROYING")

				if (randi() % 9 <=1):
					var stream
					var music = AudioStreamPlayer.new()
					if (randi() % 3 <= 1):
						stream = load("res://SFX/197772__onteca__building_collapse02_close.wav")
					else:
						stream = load("res://SFX/750822__artninja__custom_short_explosion_impact_sound.wav")
					
					music.set_stream(stream)
					music.volume_db = -15
					get_tree().root.add_child(music)
					music.play()
				
				shell.destroy()
			#ani.play("temp_crumble")
