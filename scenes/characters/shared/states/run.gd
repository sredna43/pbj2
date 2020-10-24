# Run state, player is on ground and moving

extends PlayerState

func run(player: KinematicBody2D, delta: float):
    # Accelerate the player to the run speed
    if abs(player.horizontal) > 0 and abs(player.vx + player.horizontal) < player.run_speed:
        player.vx += player.horizontal * player.acceleration
    player.vx = clamp(player.vx, -player.run_speed, player.run_speed)
    player.apply_gravity(player.gravity, delta)
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
