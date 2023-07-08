extends CharacterBody2D

@export var person: CharacterBody2D
@export var player: Player
@export var min_distance: float
@export var acceleration: float
@export var terminal_velocity: float

func _physics_process(delta):
	var displacement: Vector2 = person.position - position
	
	if displacement.length() <= min_distance:
		return
	
	var direction: Vector2 = displacement.normalized()
	if velocity.length() >= terminal_velocity:
		velocity = direction * terminal_velocity
	else:
		velocity += acceleration * delta * direction

	move_and_slide()
	
	for i in range(get_slide_collision_count()):
		var collision_data: KinematicCollision2D = get_slide_collision(i)
		if collision_data.get_collider().is_in_group("person"):
			player.kill()
			set_process(false)
			set_physics_process(false)

	$AnimatedSprite2D.flip_h = velocity.x < 0
