extends KinematicBody2D

const ACCELERATION = 700
const MAX_SPEED = 200
const FRICTION = 0.7
const AIR_RESISTANCE = 0.01 
const GRAVITY = 400
const JUMP_FORCE = 175

var motion = Vector2.ZERO
var x_input 
var y_input 
var is_grounded = true
var blend_pos = 0


onready var sprite = $"archerSprite"
onready var animPlayer = $AnimationPlayer
onready var animTree = $AnimationTree
onready var animState = animTree.get("parameters/playback")
onready var groundRay = get_node("groundRay")

func _ready():
	animTree.active = true
	Global.node_player = self
	set_process_input(true)
	
func _exit_tree():
	Global.node_player = null		
			
func _handle_move_input():
	x_input = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	y_input = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	if x_input > 0:
		blend_pos = 1
	elif x_input < 0:
		blend_pos = -1 
	set_blend_position(blend_pos)
	
func _apply_gravity(delta):
	motion.y += GRAVITY * delta
	
func _apply_movement():
	is_grounded = is_on_floor() or groundRay.is_colliding()
	motion = move_and_slide(motion, Vector2.UP)  ## Make Vector2(0,-1) as the up direction 	
				
	
func set_blend_position(x_input: int) -> void:	
	animTree["parameters/Idle/blend_position"] = x_input
	animTree["parameters/Run/blend_position"] = x_input
	animTree["parameters/Jump/blend_position"] = x_input
	animTree["parameters/Fall/blend_position"] = x_input
