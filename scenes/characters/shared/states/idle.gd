# Idle state, on ground not moving

extends PlayerState

func run(player: KinematicBody2D):
    if player.vy > 0:
        player.vy = 0
    if player.horizontal == 0 and player.vertical > 0:
        player.apply_gravity(player.gravity)
        player.move()
    if not player.grounded:
        return "air"
    if player.jumping:
        return "jump"
    if player.horizontal != 0:
        return "run"
    return null
