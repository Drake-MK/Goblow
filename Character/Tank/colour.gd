extends Sprite2D

@onready var col = $"."  # Reference to the Sprite2D itself

var a = ['#000000', '#011000', '#12a2a2', '#280007']  # Hex colors
var index = 0  # Track current color index

func _ready():
	col.modulate = Color(a[index])  # Set initial color

func _input(event):
	if Input.is_action_just_pressed("ui_accept"):
		index = (index + 1) % a.size()  # Cycle through colors
		col.modulate = Color(a[index])  # Update color
