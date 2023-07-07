extends State

class_name PersonState

var jump_timer: Timer
var gravity: float

var can_jump: bool = false

func _init(_target: CharacterBody2D):
	super(_target)
	jump_timer = target.get_node("JumpTimer")
	gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func physics_update(delta: float, terminal_velocity: float, damping: float):
	acceleration.y = gravity
	
	if not jump_timer.is_stopped() and target.is_on_floor():
		target.velocity.y = - sqrt(2 * gravity * target.jump_height)
		jump_timer.stop()
	
	super(delta, terminal_velocity, damping)

func update(delta):
	if Input.is_action_just_pressed("jump") and jump_timer.is_stopped():
		jump_timer.start()
