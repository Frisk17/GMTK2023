extends Area2D

@export var player: Player

func _process(_delta):
	for body in get_overlapping_bodies():
		if not body.is_in_group("person"):
			continue
		
		player.kill()
