# Run state, player is on ground and moving

extends PlayerState

func run(player: KinematicBody2D):
    player.vx = player.horizontal * player.run_speed
    player.apply_gravity(player.gravity)
    player.move()
    if not player.is_on_floor():
        return "air"
    if player.horizontal == 0:
        return "idle"
    if player.vy > 0:
        player.vy = 0
    if player.jumping:
        return "jump"
    return null