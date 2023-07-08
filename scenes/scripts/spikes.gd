extends Area2D

@export var player: Player

@onready var enemy = get_tree().root.get_node("/root/Game/Enemy")

func _process(_delta):
	if player.dead:
		return
	
	for body in get_overlapping_bodies():
		if not body.is_in_group("person"):
			continue
		
		enemy.set_process(false)
		enemy.set_physics_process(false)
		player.kill()
