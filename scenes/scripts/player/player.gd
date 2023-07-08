extends Node

class_name Player

@export var person: CharacterBody2D
@export var terminal_velocity: float
@export var damping: float

@onready var state: State = PersonState.new(person)

var dead: bool = false

func _ready():
	state.state_enter()

func _process(delta):
	state.update(delta)

func _physics_process(delta):
	state.physics_update(delta, terminal_velocity, damping)

func kill():
	terminal_velocity = 0
	person.get_node("AnimatedSprite2D").modulate = Color("D54B36")
	set_physics_process(false)
	dead = true

func change_state(new_state: State):
	state.state_exit()
	state.queue_free()
	
	new_state.state_enter()
	state = new_state
