# Base class for enemy states

extends Node
class_name EnemyState

export var tag : String = ""

func _ready() -> void:
    tag = name.to_lower()
    
func enter(enemy: KinematicBody2D):
    enemy.play_anim(tag)
    
func run(enemy: KinematicBody2D):
    pass

func exit(enemy: KinematicBody2D):
    pass
