extends CharacterBody2D

@onready var sprite = $sprite
@onready var anim = $anim
@export var flip_mech = false
enum state {idle,run,attack,death}

var current_state = state.idle
var speed = 100
 
func _ready():
	current_state = state.idle

func _process(delta):
	match current_state:
		state.idle : anim.play('idle')
		state.run : anim.play("run") 
		state.attack : anim.play("attack")
		state.death : anim.play("death")

func run():
	current_state = state.run	
func idle():
	current_state = state.idle
func attack():
	if current_state == state.attack :
		anim.play("attack")
	else: current_state = state.attack
func death():
	current_state = state.death
	

func flip_out():
	sprite.flip_h = flip_mech

func flip():
	sprite.flip_h = not sprite.flip_h
	
