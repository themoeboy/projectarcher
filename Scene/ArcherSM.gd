extends "res://Script/StateMachine.gd"

var arrow = preload("res://Scene/Arrow.tscn")
func _handle_input(delta):
	if [states.run,states.idle].has(state):
		parent.motion.x += parent.x_input * parent.ACCELERATION * delta 
		parent.motion.x = clamp(parent.motion.x, - parent.MAX_SPEED, parent.MAX_SPEED) # Set a max speed on all directions 
	
	if Input.is_action_just_pressed("ui_left_click"):
		Global.instance_node(arrow,Global.node_player.global_position + Vector2(0,-15),Global.node_creation_parent)		
	if parent.is_grounded:
		if parent.x_input == 0 and parent.y_input == 0:
			parent.motion.x = lerp(parent.motion.x, 0,parent.FRICTION) # Approach stopping motion after moving
		if Input.is_action_just_pressed("ui_up"):
			parent.motion.y = -parent.JUMP_FORCE  # Upwards motion is -y in 2d space
	else:
		if parent.x_input == 0 and [states.jump,states.fall].has(state):
			parent.motion.x = lerp(parent.motion.x, 0, parent.AIR_RESISTANCE) # Air resistance
			
func _ready():
	add_state("run")
	add_state("idle")
	add_state("jump")
	add_state("fall")
	call_deferred("set_state", states.idle)

func _state_logic(delta):
	print(state)
	parent._handle_move_input()
	parent._apply_gravity(delta)
	_handle_input(delta)
	parent._apply_movement()
	
	pass

func _get_transition(delta):
	match state:
		states.idle:
			if !parent.is_grounded:
				if parent.motion.y <0:
					return states.jump
				elif parent.motiwwwwwwwwwwwwaon.y >0:
					return states.fall
			elif abs(parent.motion.x) > 1:
				return states.run
		states.run:
			if !parent.is_grounded:
				if parent.motion.y <0:
					return states.jump
				elif parent.motion.y >0:
					return states.fall
			elif abs(parent.motion.x) < 1:
				return states.idle
		states.jump:
			if parent.is_grounded:
				if abs(parent.motion.x) > 1:
					return states.run
				else:
					return states.idle
			elif parent.motion.y >=0:
				return states.fall
		states.fall:
			if parent.is_grounded:
				if abs(parent.motion.x) > 1:
					return states.run
				else:
					return states.idle
			elif parent.motion.y < 0:
				return states.jump
	
func _enter_state(new_state,old_state):
	match new_state:
		states.idle:
			parent.animState.travel("Idle")
		states.run:	
			parent.animState.travel("Run")
		states.jump:
			parent.animState.travel("Jump")
		states.fall:
			parent.animState.travel("Fall")

func _exit_state(old_state, new_state):
	pass
