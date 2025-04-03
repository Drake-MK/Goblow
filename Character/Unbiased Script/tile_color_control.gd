extends CanvasModulate

@onready var canvas = $"."


# Called when the node enters the scene tree for the first time.
func _ready():
	canvas.visible = true
	canvas.color = Color('#000000')
