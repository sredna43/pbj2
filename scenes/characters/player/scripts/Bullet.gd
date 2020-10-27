extends KinematicBody2D

var velocity : Vector2 = Vector2.ZERO
var direction : int = 0
var remove = false
onready var explosion : CPUParticles2D = $Explosion    

func _ready() -> void:
    set_as_toplevel(true)
    velocity.y = -40
    
func _physics_process(delta: float) -> void:
    velocity.y += 40
    if is_on_wall():
        $Sprite.visible = false
        collision_layer = 0
        velocity = Vector2.ZERO
        explosion.direction.x = direction
        explosion.emitting = true
        get_tree().create_timer(explosion.lifetime).connect("timeout", self, "queue_free")
    else:
        velocity.x = 650 * direction
        if is_on_floor():
            velocity.y = -300
    velocity = move_and_slide(velocity, Vector2.UP)
