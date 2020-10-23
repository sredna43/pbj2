# Air state, player is currently in the air

extends PlayerState

func enter(player:KinematicBody2D):
    # if player.anim.current_animation == "jump":
    # 	yield (player.anim, "animation_finished")
    # 	if player.state_machine.active_state.tag == tag:
    # 		.enter(player) # Base class
    # else:
    # 	.enter(player) # Base class
    .enter(player)

func run(player: KinematicBody2D):
    player.vx = player.horizontal * player.midair_speed
    player.apply_gravity(player.gravity)
    player.move()
    if player.is_on_floor():
        return "idle" if player.horizontal == 0 else "run"
    if player.grounded and player.jumping:
        return "jump"
