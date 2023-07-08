extends Area2D

var win = preload("res://scenes/win.tscn")

func _process(_delta):
	for body in get_overlapping_bodies():
		if not body.is_in_group("person"):
			continue
		
		$WinSound.play()
		set_process(false)
		await $WinSound.finished

		get_tree().change_scene_to_packed(win)
