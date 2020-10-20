# This script will likely handle movement of the PeanutButter character

extends "res://scripts/player_constants.gd"

var velocity = Vector2()
var direction = Vector2()


func _ready() -> void:
	velocity.y = 1

func _physics_process(_delta: float) -> void:
	velocity.y += GRAVITY * _delta
	velocity = .move_and_slide(velocity, Vector2.UP)
