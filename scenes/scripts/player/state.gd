extends Object

class_name State

var target: CharacterBody2D
var acceleration: Vector2 = Vector2.ZERO

func _init(_target: CharacterBody2D):
	target = _target

func state_enter():
	pass

func update(delta):
	pass

func physics_update(delta: float, terminal_velocity: float, damping: float):
	acceleration.x = damping * (terminal_velocity * Input.get_axis("move_left", "move_right") - target.velocity.x)
	target.velocity += acceleration * delta
	
	target.move_and_slide()

func state_exit():
	pass
