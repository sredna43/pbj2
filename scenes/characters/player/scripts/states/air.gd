# Air state, player is currently in the air

extends PlayerState

func enter(player:KinematicBody2D):
	if player.anim.current_animation == "jump":
		yield (player.anim, "animation_finished")
		if player.state_machine.active_state.tag == tag:
			.enter(player) # Base class
	else:
		.enter(player) # Base class
	.enter(player)

func run(player: KinematicBody2D, delta: float):
	if abs(player.horizontal) > 0 and abs(player.vx + player.horizontal) < player.run_speed:
		player.vx += player.horizontal * player.midair_speed
	player.vx = clamp(player.vx, -player.run_speed, player.run_speed)
	if abs(player.vx) > 0 && player.horizontal == 0:
		player.vx = lerp(player.vx, 0, player.air_resistance)
	player.apply_gravity(player.gravity, delta)
	player.move()
	if player.shooting:
		return "shoot"
	if player.is_on_floor() and player.velocity.y == 0:
		return "idle" if player.horizontal == 0 else "run"
	if player.grounded and player.jumping:
		return "jump"
	if player.get_wall_slide() and player.velocity.y > 0:
		return "slide"
	return null
