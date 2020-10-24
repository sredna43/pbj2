# Idle state, on ground not moving

extends PlayerState

func run(player: KinematicBody2D, delta: float):
    if abs(player.vx) > 0:
        player.vx = 0
    if player.vy > 0:
        player.vy = 0
    # Fall through the floor
    if player.horizontal == 0 and player.vertical > 0:
        player.apply_gravity(player.gravity, delta)
        player.move()
    
    if not player.is_on_floor():
        return "air"
    if player.jumping:
        return "jump"
    if player.horizontal != 0:
        return "run"
    return null
