extends Node3D

@export var turn = 0
@export var kitty = $KittyBody3D
@export var mouse = $MouseBody3D
@export var ai = $AIKittyBody3D


# Called when the node enters the scene tree for the first time.
func _ready():
	if turn == 0:
		kitty.set_process(true)
		mouse.set_process(false)
		ai.set_process(false)
	else:
		kitty.set_process(dals)
		mouse.set_process(false)
		ai.set_process(false)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
