extends Node

@export var person: CharacterBody2D
@export var terminal_velocity: float
@export var damping: float

@onready var state: State = PersonState.new(person)

func _process(delta):
	state.update(delta)

func _physics_process(delta):
	state.physics_update(delta, terminal_velocity, damping)

func change_state(new_state: State):
	state.state_exit()
	state.free()
	
	new_state.state_enter()
	state = new_state
