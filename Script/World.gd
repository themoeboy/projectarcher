extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	Global.node_creation_parent = self

func _exit_tree():
	Global.node_creation_parent = null


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
