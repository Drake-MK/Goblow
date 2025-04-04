extends CharacterBody2D

@onready var col = $CanvasModulate
var gravity = 100

var a = ['#000000', '#011000', '#12a2a2', '#280007']  # Make sure hex values start with #
var index = 0  # Track the current color index

func _ready():
	col.color = Color(a[index])  # Set initial color

func _input(event):
	if Input.is_action_just_pressed("ui_accept"):
		index = (index + 1) % a.size()  # Cycle through the array
		col.color = Color(a[index])  # Update color

func _process(delta):
	if not is_on_floor():
		print('fallins')
		velocity.y += gravity * delta
	move_and_slide()
