# Jump state, player has just pressed the jump key

extends PlayerState

export var jump_power : float = 700

func run(player: KinematicBody2D):
    player.vy = -jump_power
    player.move()
    return "air"