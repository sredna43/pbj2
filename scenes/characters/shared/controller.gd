extends KinematicBody2D
class_name Player
signal hud

# Player movement
export var gravity : float = 60
export var run_speed : float = 500
export var midair_speed : float = 500
export var acceleration : float = 100
var velocity : Vector2 = Vector2.ZERO
var vx: float = 0 setget _set_vx, _get_vx
var vy: float = 0 setget _set_vy, _get_vy

# Player control
export var pb_or_j : String = ""
var horizontal : int = 0
var vertical : int = 0
onready var jump_timer : Timer = $Timers/JumpTimer
onready var floor_timer : Timer = $Timers/FloorTimer

# Player position
var grounded : bool = false setget ,_get_grounded
var jumping : bool = false setget ,_get_jumping

# State Machine
onready var state_machine : PlayerFSM = $States

func _ready():
    state_machine.init(self)

func _physics_process(_delta: float) -> void:
    update_inputs()
    state_machine.run()
    emit_signal("hud", "%s x: %s \t y: %s \t state: %s" % [pb_or_j, velocity.x, velocity.y, state_machine.active_state.tag])

func update_inputs() -> void:
    horizontal = (
        int(Input.is_action_pressed("%s_right" % pb_or_j))
         - int(Input.is_action_pressed("%s_left" % pb_or_j)))
    vertical = (
        int(Input.is_action_pressed("%s_down" % pb_or_j))
        - int(Input.is_action_pressed("%s_jump" % pb_or_j))
    )
    if Input.is_action_pressed("%s_jump" % pb_or_j):
        jump_timer.start()
    if is_on_floor():
        floor_timer.start()

func move():
    velocity = move_and_slide(velocity, Vector2.UP, true)

func apply_gravity(g : float):
    velocity += Vector2.DOWN * g

func play(animation : String):
    pass

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