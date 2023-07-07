extends Node

@export var person: CharacterBody2D
@export var terminal_velocity: float
@export var damping: float

@onready var state: State = PersonState.new(person)

var camera_velocity: Vector2 = Vector2.ZERO
var camera_acceleration: Vector2 = Vector2.ZERO
@onready var camera_target_position: Vector2 = state.target.position
@export var camera_terminal_velocity: float
@export var camera_damping: float
@export var camera_deadzone: float

func _ready():
	state.state_enter()

func _process(delta):
	state.update(delta)

func _physics_process(delta):
	state.physics_update(delta, terminal_velocity, damping)
	move_camera(delta)

func change_state(new_state: State):
	state.state_exit()
	state.free()
	
	new_state.state_enter()
	state = new_state

func move_camera(delta):
	$Camera2D.position = state.target.position
