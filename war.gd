extends Node2D
@onready var mech_anim = $"mecha/mech-anim"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func wat():print('war')
func _input(event):
	
	if Input.is_action_just_pressed("ui_up"):
		mech_anim.play("war")
		print(mech_anim)
		print('war')
	if Input.is_action_just_pressed("ui_down"):
		mech_anim.play("peace")
	if Input.is_action_just_pressed("ui_left"):
		mech_anim.play("idle")
