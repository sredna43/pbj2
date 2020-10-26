extends Node2D

var bullet = preload("res://scenes/characters/player/Bullet.tscn")

func fire(direction : int):
	var new_bullet = bullet.instance()
	new_bullet.direction = direction
	add_child(new_bullet)
