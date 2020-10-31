# Mostly used for debugging, controls the HUD

extends CanvasLayer

export var player : String = "PBPlayer"

func _ready() -> void:
    var p = owner.get_node(player)
    p.connect("hud", self, "set_text")
    $Label.align = Label.ALIGN_LEFT if player else Label.ALIGN_RIGHT

func set_text(text):
    $Label.text = str(text)
