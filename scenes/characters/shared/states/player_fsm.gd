# Base Finite State Machine to be used by both players

extends Node2D
class_name PlayerFSM

var states: Dictionary = {}
var active_state: PlayerState
var previous_state : String = ""
var player: KinematicBody2D

func init_states():
	for state in get_children():
		if state.tag:
			states[state.tag] = state

func init(p: KinematicBody2D):
	player = p
	init_states()
	active_state = states.idle
	active_state.enter(player)

func run(delta: float):
	var next_state_tag = active_state.run(player, delta)
	if next_state_tag:
		change_state(next_state_tag)

func change_state(next_state_tag: String):
	var next_state = states.get(next_state_tag)
	if next_state:
		previous_state = active_state.tag
		active_state.exit(player)
		active_state = next_state
		active_state.enter(player)
