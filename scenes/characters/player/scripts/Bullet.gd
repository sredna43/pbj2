extends KinematicBody2D

var velocity : Vector2 = Vector2.ZERO

func _ready() -> void:
	velocity.x = 700
	set_as_toplevel(true)
	
func _physics_process(delta: float) -> void:
	velocity.y += 30
	velocity = move_and_slide(velocity, Vector2.UP)
	if get_slide_count():
		queue_free()
