extends Area2D

@export var player: Player
@export var platform: CharacterBody2D

var clicked: bool = false

func _process(delta):
	if not clicked and not get_overlapping_bodies().is_empty():
		for body in get_overlapping_bodies():
			if body.is_in_group("person"):
				$AnimatedSprite2D.play("clicked")
				clicked = true
				player.change_state(PlatformState.new(platform))
				return
