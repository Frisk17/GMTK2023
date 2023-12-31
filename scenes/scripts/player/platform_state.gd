extends State

class_name PlatformState

var player: Player
var sprite: Sprite2D

func _init(_target: CharacterBody2D):
	super(_target)
	sprite = target.get_node("Sprite2D")
	player = target.get_tree().root.get_node("/root/Game/Player")

func state_enter():
	super()
	sprite.modulate = Color("F3D272")
	if player.switch_tutorial and Player.tutorial:
		target.get_node("/root/Game/CanvasLayer/SwitchLabel").visible = true

func state_exit():
	sprite.modulate = Color("485A74")
	if player.switch_tutorial and Player.tutorial:
		target.get_node("/root/Game/CanvasLayer/SwitchLabel").visible = false
		player.switch_tutorial = false
		player.tutorial = false

func update(_delta):
	if Input.is_action_just_pressed("switch"):
		target.get_node("SwitchSound").play()
		player.change_state(PersonState.new(player.person))

func physics_update(delta: float, terminal_velocity: float, damping: float):
	acceleration.y = damping * (Input.get_axis("move_up", "move_down") * terminal_velocity - target.velocity.y)
	
	super(delta, terminal_velocity, damping)
