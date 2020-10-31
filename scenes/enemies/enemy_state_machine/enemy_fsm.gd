# Finite State Machine to be used by all enemies. Controls flow of states.

extends Node2D
class_name EnemyFSM

var states: Dictionary = {}
var active_state: EnemyState
var previous_state : String = ""
var enemy: KinematicBody2D
