extends Node3D

#Create Node3d children of CheeseSpawner and place them around the map
#Every CheeseTimer seconds there is a 1/CheeseOdds chance that one of those spots
#will get cheese placed in its location. Each spot can only spawn 1 piece of cheese
#Fine tuning required, though unlikely to be achieved

@export var cheeseOdds = 10
@export var cheeseTimer = 3.0

var spawnLocations = Array([], TYPE_OBJECT, "Node3D", null)        # Array[Node]
var numLocations = 0
var timeSinceLastCheesed = 0


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for _i in self.get_children():
		spawnLocations.append(_i)
		numLocations += 1

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#keeps track of time
	timeSinceLastCheesed += delta
	
	#once enough time has elapsed,
	if (timeSinceLastCheesed >= cheeseTimer && numLocations != 0):
		timeSinceLastCheesed = 0
		#1/cheeseOdds chance of spawning a cheese
		if (randi() % cheeseOdds <= 1):
			var cheeseLocation = randi() % numLocations
			
			var cheese = preload("res://Scenes/yarn.tscn").instantiate()
			add_child(cheese)
			
			cheese.position = spawnLocations[cheeseLocation].position
			
			spawnLocations.remove_at(cheeseLocation)
			numLocations -= 1
			
			print ("Spawning yarn at spot: ", cheeseLocation)
