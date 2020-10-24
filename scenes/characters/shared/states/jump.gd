# Jump state, player has just pressed the jump key

extends PlayerState


func run(player: KinematicBody2D, delta: float):
    player.vy = -player.jump_power * delta
    player.move()
    return "air"
