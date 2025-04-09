extends Node2D

@onready var anim_main = $"anim main"
@onready var final = $final
@onready var audio_player = $keys  # Add an AudioStreamPlayer node
var notes = {}  # Dictionary to store key-note mappings

signal interesting
signal ignoring
signal naching

var melodies = {
	# sleepy
	"Snowdin Theme": [KEY_7, KEY_3, KEY_4, KEY_7],
	"Celeste (Easy)": [KEY_3, KEY_7, KEY_1, KEY_6],
	"Celeste (Ambient)": [KEY_1, KEY_6, KEY_3, KEY_7],
	# creepy
	"Lavender Town": [KEY_5, KEY_7, KEY_4, KEY_5],
	"Silent Hill": [KEY_7, KEY_4, KEY_3, KEY_7],
	# war
	"Dark Souls": [KEY_6, KEY_3, KEY_1, KEY_4],
	"God of War": [KEY_5, KEY_7, KEY_4, KEY_1],
	"Doom Eternal": [KEY_3, KEY_7, KEY_1, KEY_6],
	"Zelda Lullaby": [KEY_7, KEY_4, KEY_5, KEY_3],
	# peace
	"To Zanarkand": [KEY_5, KEY_2, KEY_3, KEY_7],
	"Suteki Da Ne": [KEY_4, KEY_1, KEY_7, KEY_4],
}

var keys = melodies.keys()	
var sleepy = keys.slice(0, 3)
var creepy = keys.slice(3, 5)  # Fixed slice range (was 3, 6, but only 2 creepy themes)
var war = keys.slice(5, 8)    # Adjusted for correct range
var peace = keys.slice(8, 11) # Adjusted for correct range

var player = []
var random_threshold = 8  # Number of notes before checking for randomness

func _ready():
	print(keys, sleepy, creepy, war, peace)
	# Define keyboard keys mapped to note sounds
	notes = {
		KEY_Q: preload("res://Asset/paino/A1.mp3"),
		KEY_W: preload("res://Asset/paino/B1.mp3"),
		KEY_E: preload("res://Asset/paino/C1.mp3"),
		KEY_R: preload("res://Asset/paino/D1.mp3"),
		KEY_T: preload("res://Asset/paino/E1.mp3"),
		KEY_Y: preload("res://Asset/paino/F1.mp3"),
		KEY_U: preload("res://Asset/paino/G1.mp3"),
		KEY_A: preload("res://Asset/paino/A2.mp3"),
		KEY_S: preload("res://Asset/paino/B2.mp3"),
		KEY_D: preload("res://Asset/paino/C2.mp3"),
		KEY_F: preload("res://Asset/paino/D2.mp3"),
		KEY_G: preload("res://Asset/paino/E2.mp3"),
		KEY_H: preload("res://Asset/paino/F2.mp3"),
		KEY_J: preload("res://Asset/paino/G2.mp3"),
		KEY_Z: preload("res://Asset/paino/A3.mp3"),
		KEY_X: preload("res://Asset/paino/B3.mp3"),
		KEY_C: preload("res://Asset/paino/C3.mp3"),
		KEY_V: preload("res://Asset/paino/D3.mp3"),
		KEY_B: preload("res://Asset/paino/E3.mp3"),
		KEY_N: preload("res://Asset/paino/F3.mp3"),
		KEY_M: preload("res://Asset/paino/G3.mp3"),
		KEY_1: preload("res://Asset/paino/A4.mp3"),
		KEY_2: preload("res://Asset/paino/B4.mp3"),
		KEY_3: preload("res://Asset/paino/C4.mp3"),
		KEY_4: preload("res://Asset/paino/D4.mp3"),
		KEY_5: preload("res://Asset/paino/E4.mp3"),
		KEY_6: preload("res://Asset/paino/F4.mp3"),
		KEY_7: preload("res://Asset/paino/G4.mp3"),
		KEY_8: preload("res://Asset/paino/A5.mp3"),
		KEY_9: preload("res://Asset/paino/B5.mp3"),
		KEY_0: preload("res://Asset/paino/C5.mp3"),
	}

func _input(event):
	if Input.is_action_just_pressed('ui_up'):
		anim_main.play("at_war")
	if Input.is_action_just_pressed('ui_down'):
		if anim_main.current_animation == 'at_idle':
			anim_main.play("at_peace")
	if Input.is_action_just_pressed('ui_left'):
		anim_main.play("at_idle")
	
	if event is InputEventKey and event.pressed and event.keycode in notes:
		player.append(event.keycode)
		if player.size() > random_threshold:
			player.pop_front()
		
		# Check all melodies
		var melody_matched = false
		for name in melodies.keys():
			if has_sequence(player, melodies[name]):
				melody_matched = true
				if name in war:
					print('war')
					anim_main.play("at_war")
				if name in peace:
					print('peace')
					if anim_main.current_animation == 'at_idle':
						anim_main.play("at_peace")
				if name in creepy:
					anim_main.play("at_death")
				if name in sleepy:
					print('sleepy')
					anim_main.play("at_idle")
				player.clear()
				break
		
		# If no melody matched and player has played enough random notes
		if not melody_matched and player.size() >= random_threshold:
			print("Random chaos detected!")
			anim_main.play("at_war")
			player.clear()
		
		audio_player.stream = notes[event.keycode]
		audio_player.play()

func has_sequence(big: Array, small: Array) -> bool:
	for i in big.size() - small.size() + 1:
		if big.slice(i, i + small.size()) == small:
			return true
	return false
