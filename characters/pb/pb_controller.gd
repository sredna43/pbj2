extends KinematicBody2D
class_name Player

# Player movement
export var gravity : float = 60
var velocity : Vector2 = Vector2.ZERO
var vx: float = 0 setget _set_vx, _get_vx
var vy: float = 0 setget _set_vy, _get_vy

# Player control
var horizontal : int = 0
var vertical : int = 0

# State Machine
onready var state_machine : PlayerFSM = $States

func _ready():
    state_machine.init(self)

func _physics_process(_delta: float) -> void:
    update_inputs()
    state_machine.run()

func update_inputs() -> void:
    horizontal = (
        int(Input.is_action_pressed("pb_right"))
         - int(Input.is_action_pressed("pb_left")))
    vertical = (
        int(Input.is_action_pressed("pb_down"))
        - int(Input.is_action_pressed("pb_jump"))
    )

func move():
    velocity = move_and_slide(velocity, Vector2.UP, true)

func apply_gravity():
    velocity += Vector2.DOWN * gravity

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