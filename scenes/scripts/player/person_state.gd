extends State

class_name PersonState

var jump_timer: Timer
var animated_sprite: AnimatedSprite2D
var gravity: float

var can_jump: bool = false

func _init(_target: CharacterBody2D):
	super(_target)
	jump_timer = target.get_node("JumpTimer")
	animated_sprite = target.get_node("AnimatedSprite2D")
	gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func physics_update(delta: float, terminal_velocity: float, damping: float):
	acceleration.y = gravity
	
	if not jump_timer.is_stopped() and target.is_on_floor():
		target.velocity.y = - sqrt(2 * gravity * target.jump_height)
		jump_timer.stop()
	
	super(delta, terminal_velocity, damping)
	
	if not is_equal_approx(target.velocity.x, 0):
		animated_sprite.flip_h = target.velocity.x < 0

	if not target.is_on_floor():
		if animated_sprite.animation == "running" and animated_sprite.frame in [1, 5]:
			return

		animated_sprite.play("airborne")
	elif abs(target.velocity.x) <= target.min_animation_velocity:
		if animated_sprite.animation == "running" and animated_sprite.frame in [1, 5]:
			return

		animated_sprite.play("idle")
	else:
		animated_sprite.play("running")

func state_enter():
	super()
	animated_sprite.modulate = Color("F3D272")

func state_exit():
	animated_sprite.play("idle")
	animated_sprite.modulate = Color("485A74")

func update(_delta):
	if Input.is_action_just_pressed("jump") and jump_timer.is_stopped():
		jump_timer.start()
