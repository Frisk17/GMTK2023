extends VBoxContainer

var game = preload("res://scenes/game.tscn")

func _on_play_button_pressed():
	get_tree().change_scene_to_packed(game)

func _on_exit_button_pressed():
	get_tree().quit(0)
