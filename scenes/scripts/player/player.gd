extends Node

class_name Player

@export var person: CharacterBody2D
@export var game_over_label: Label
@export var terminal_velocity: float
@export var damping: float

@onready var state: State = PersonState.new(person)

var dead: bool = false

func _ready():
	state.state_enter()

func _process(delta):
	if not dead:
		state.update(delta)
	elif Input.is_key_pressed(KEY_SPACE):
		get_tree().reload_current_scene()

func _physics_process(delta):
	state.physics_update(delta, terminal_velocity, damping)

func kill():
	terminal_velocity = 0
	person.get_node("AnimatedSprite2D").play("idle")
	person.get_node("AnimatedSprite2D").modulate = Color("D54B36")
	set_physics_process(false)
	game_over_label.visible = true
	dead = true

func change_state(new_state: State):
	state.state_exit()
	state.queue_free()
	
	new_state.state_enter()
	state = new_state
