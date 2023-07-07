extends State

class_name PlatformState

func physics_update(delta: float, terminal_velocity: float, damping: float):
	acceleration.y = damping * (Input.get_axis("move_up", "move_down") * terminal_velocity - target.velocity.y)
	
	super(delta, terminal_velocity, damping)
