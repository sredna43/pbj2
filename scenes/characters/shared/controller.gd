extends KinematicBody2D
class_name Player
signal hud

# Player movement
export var terminal_vel : float = 700
export var jump_power : float = 363
export var slide_friction : float = 70
export var gravity : float = 40
export var run_speed : float = 350
export var midair_speed : float = 25
export var air_resistance : float = 0.05
export var acceleration : float = 50
export var friction : float = 0.8
var velocity : Vector2 = Vector2.ZERO
var vx: float = 0 setget _set_vx, _get_vx
var vy: float = 0 setget _set_vy, _get_vy

# Player control
export var pb_or_j : String = ""
var horizontal : int = 0
var vertical : int = 0
onready var jump_timer : Timer = $Timers/JumpTimer
onready var floor_timer : Timer = $Timers/FloorTimer
onready var l_wall : RayCast2D = $Rays/LCast
onready var r_wall : RayCast2D = $Rays/RCast

# Player position
var grounded : bool = false setget ,_get_grounded
var jumping : bool = false setget ,_get_jumping
onready var floor_collision : CollisionShape2D = $FloorCollision

# State Machine
onready var state_machine : PlayerFSM = $States

# AnimationPlayer
onready var anim : AnimationPlayer = $Sprite/AnimationPlayer

func _ready():
	state_machine.init(self)

func _physics_process(_delta: float) -> void:
	update_inputs()
	state_machine.run(_delta)
	emit_signal("hud", "%s x: %s \t y: %s \t state: %s" % [pb_or_j, velocity.x, velocity.y, state_machine.active_state.tag])

func update_inputs() -> void:
	horizontal = (
		int(Input.is_action_pressed("%s_right" % pb_or_j))
		 - int(Input.is_action_pressed("%s_left" % pb_or_j)))
	vertical = (
		int(Input.is_action_pressed("%s_down" % pb_or_j))
		- int(Input.is_action_pressed("%s_jump" % pb_or_j))
	)
	if Input.is_action_just_pressed("%s_jump" % pb_or_j):
		jump_timer.start()
	if is_on_floor():
		velocity.y = 0
		floor_timer.start()

func move():
	update_look_direction()
	velocity = move_and_slide(velocity, Vector2.UP, true)

func update_look_direction(flip : int = 0):
	if flip == -1:
		$Sprite.flip_h = true
		floor_collision.position.x = -0.75
	if flip == 1:
		$Sprite.flip_h = false
		floor_collision.position.x = 0.75
	if horizontal < 0 and not get_wall_slide():
		$Sprite.flip_h = true
		floor_collision.position.x = -0.75
	if horizontal > 0 and not get_wall_slide():
		$Sprite.flip_h = false
		floor_collision.position.x = 0.75

func apply_gravity(g : float, _delta : float):
	if velocity.y <= terminal_vel:
		velocity += Vector2.DOWN * g
	
func get_wall_slide() -> int:
	if l_wall.is_colliding():
		return 1
	if r_wall.is_colliding():
		return -1
	return 0

func play(animation : String):
	if anim.current_animation == animation:
		return
	anim.play(animation)

# Set-Get functions
func _get_vx():
	return vx

func _set_vx(val:float):
	#if val != 0:
	#    sprite.flip_h = (val < 0)
	velocity.x = val
	vx = val

func _get_vy():
	return vy

func _set_vy(val:float):
	velocity.y = val
	vy = val

func _get_grounded():
	grounded = not floor_timer.is_stopped()
	return grounded

func _get_jumping():
	jumping = not jump_timer.is_stopped()
	return jumping
