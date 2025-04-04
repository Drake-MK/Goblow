extends CharacterBody2D

@onready var sprite = $sprite
@onready var anim = $anim

enum state {idle,run,attack}

var current_state = state.idle
 
func _ready():
	current_state = state.idle
	
func _process(delta):
	match current_state:
		state.idle : anim.play('idle')
		state.run : anim.play("run") 
		state.attack : anim.play("attack")

func run():
	current_state = state.run	
func idle():
	current_state = state.idle
func attack():
	current_state = state.attack
	
func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta		

	move_and_slide()
	
func flip():
	sprite.flip_h = not sprite.flip_h
