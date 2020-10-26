extends Node2D

var bullet = preload("res://scenes/characters/player/Bullet.tscn")
onready var location = get_parent()

func fire(direction : int):
    location.position = Vector2(5,4) if direction == 1 else Vector2(-5,4)
    var new_bullet = bullet.instance()
    new_bullet.direction = direction
    add_child(new_bullet)
