# Attack state, whenever the player presses the attack button

extends PlayerState
signal fire

func run(player: KinematicBody2D, _delta: float):
	emit_signal("fire")
	
	# Go back to previous state, handle things from there
	return player.state_stack[0]
