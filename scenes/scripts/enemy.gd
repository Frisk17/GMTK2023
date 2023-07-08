extends CharacterBody2D

@export var person: CharacterBody2D
@export var player: Player
@export var acceleration: float
@export var terminal_velocity: float

@onready var agent: NavigationAgent2D = $NavigationAgent2D

func _ready():
	call_deferred("actor_setup")

func actor_setup():
	await get_tree().physics_frame
	
	agent.target_position = person.position

func _physics_process(delta):
	for i in range(get_slide_collision_count()):
		var collision_data: KinematicCollision2D = get_slide_collision(i)
		if collision_data.get_collider().is_in_group("person"):
			player.kill()
			set_process(false)
			set_physics_process(false)

	if agent.is_navigation_finished():
		return

	var target_position: Vector2 = agent.get_next_path_position()
	var direction: Vector2 = (target_position - position).normalized()
	
	if velocity.length() >= terminal_velocity:
		velocity = terminal_velocity * direction
	else:
		velocity += acceleration * delta * direction

	move_and_slide()

	$AnimatedSprite2D.flip_h = velocity.x < 0


func _on_pathfinding_timer_timeout():
	agent.target_position = person.position
