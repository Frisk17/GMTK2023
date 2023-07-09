extends Sprite2D

@export var person: CharacterBody2D
@export var distance_to_deactivate: float

func _ready():
	if not Player.tutorial:
		visible = false

func _process(delta):
	if visible and (person.position - position).length() <= distance_to_deactivate:
		visible = false
