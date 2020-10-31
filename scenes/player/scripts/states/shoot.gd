extends PlayerState

func run(player: KinematicBody2D, _delta : float):
	player.emit_signal("shoot", self)
	var next_state = str(player.state_machine.previous_state)
	if player.shooting:
		if abs(player.horizontal) > 0 and abs(player.vx + player.horizontal) < player.run_speed:
			player.vx += player.horizontal * player.acceleration
		player.vx = clamp(player.vx, -player.run_speed, player.run_speed)
		player.apply_gravity(player.gravity, _delta)
		player.move()
		if player.jumping:
			return "jump"
		return null
	return next_state
