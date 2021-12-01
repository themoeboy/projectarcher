extends Node2D


var velocity = Vector2(1,0)

var SPEED = 400

var look_once = true  

func _process(delta):
	if look_once:
		look_at(get_global_mouse_position())
		look_once = false
	global_position += velocity.rotated(rotation) * SPEED * delta

	


func _on_Area2D_body_entered(body):
	if body.is_in_group("pivot_object"):
	  queue_free()
