# Base class for all states to work from

extends Node2D
class_name PlayerState

export var tag : String = ""
export var player_to_control : String = ""

func _ready():
    tag = name.to_lower()

# Player State

func enter(player: KinematicBody2D):
    player.play(tag)

# warning-ignore:unused_argument
func run(player: KinematicBody2D):
    return null

func exit(player: KinematicBody2D):
    # if player and player.anim:
    #     player.anim.clear_queue()
    pass
