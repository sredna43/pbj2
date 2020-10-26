extends KinematicBody2D

var velocity : Vector2 = Vector2.ZERO
var direction : int = 0

func _ready() -> void:
    set_as_toplevel(true)
    velocity.y = -10
    
func _physics_process(delta: float) -> void:
    velocity.y += 0.1
    velocity.x = 700 * direction
    velocity = move_and_slide(velocity, Vector2.UP)
    
    if get_slide_count():
        queue_free()
