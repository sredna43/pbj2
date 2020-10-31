# Slide state, when the player is colliding with a wall and should slide

extends PlayerState

func enter(player: KinematicBody2D):
    player.vy = 10
    .enter(player)

func run(player: KinematicBody2D, delta: float):
    player.update_look_direction(player.get_wall_slide())
    player.apply_gravity(player.gravity / player.slide_friction, delta)
    player.move()
    
    # Hop off wall
    if player.horizontal == player.get_wall_slide():
        player.vx = player.run_speed * player.horizontal
        player.move()
        return "air"
        
    # Jump from wall
    if player.jumping:
        player.vx = player.run_speed * player.get_wall_slide()
        return "jump"
    
    # Land on ground
    if player.grounded:
        return "run"
    
    return null
