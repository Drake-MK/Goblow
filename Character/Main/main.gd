extends Node2D

@onready var final = $final
@onready var audio_player = $keys  # Add an AudioStreamPlayer node
var notes = {}  # Dictionary to store key-note mappings

func _ready():
	# Define keyboard keys mapped to note sounds
	notes = {
		# Top Row (QWERTY)
	KEY_Q: preload("res://Asset/paino/A1.mp3"),
	KEY_W: preload("res://Asset/paino/B1.mp3"),
	KEY_E: preload("res://Asset/paino/C1.mp3"),
	KEY_R: preload("res://Asset/paino/D1.mp3"),
	KEY_T: preload("res://Asset/paino/E1.mp3"),
	KEY_Y: preload("res://Asset/paino/F1.mp3"),
	KEY_U: preload("res://Asset/paino/G1.mp3"),

	# Second Row (ASDFGHJ)
	KEY_A: preload("res://Asset/paino/A2.mp3"),
	KEY_S: preload("res://Asset/paino/B2.mp3"),
	KEY_D: preload("res://Asset/paino/C2.mp3"),
	KEY_F: preload("res://Asset/paino/D2.mp3"),
	KEY_G: preload("res://Asset/paino/E2.mp3"),
	KEY_H: preload("res://Asset/paino/F2.mp3"),
	KEY_J: preload("res://Asset/paino/G2.mp3"),

	# Third Row (ZXCVBNM)
	KEY_Z: preload("res://Asset/paino/A3.mp3"),
	KEY_X: preload("res://Asset/paino/B3.mp3"),
	KEY_C: preload("res://Asset/paino/C3.mp3"),
	KEY_V: preload("res://Asset/paino/D3.mp3"),
	KEY_B: preload("res://Asset/paino/E3.mp3"),
	KEY_N: preload("res://Asset/paino/F3.mp3"),
	KEY_M: preload("res://Asset/paino/G3.mp3"),

	# Higher Octaves
	KEY_1: preload("res://Asset/paino/A4.mp3"),
	KEY_2: preload("res://Asset/paino/B4.mp3"),
	KEY_3: preload("res://Asset/paino/C4.mp3"),
	KEY_4: preload("res://Asset/paino/D4.mp3"),
	KEY_5: preload("res://Asset/paino/E4.mp3"),
	KEY_6: preload("res://Asset/paino/F4.mp3"),
	KEY_7: preload("res://Asset/paino/G4.mp3"),
	# Continue to higher octaves
	KEY_8: preload("res://Asset/paino/A5.mp3"),
	KEY_9: preload("res://Asset/paino/B5.mp3"),
	KEY_0: preload("res://Asset/paino/C5.mp3"),
	
	}

var trial = [KEY_Q, KEY_W, KEY_E, KEY_R]
var player = []
var snowdin_theme = [KEY_7, KEY_3, KEY_4, KEY_7] # G4, C4, D4, G4
var ori_main_theme = [KEY_4, KEY_1, KEY_7, KEY_4] # D4, A4, G4, D4
var celeste_first_steps_easy = [KEY_3, KEY_7, KEY_1, KEY_6] # C4, G4, A4, F4
var celeste_first_steps_ambient = [KEY_1, KEY_6, KEY_3, KEY_7] # A4, F4, C4, G4
var lavender_town_theme = [KEY_5, KEY_7, KEY_4, KEY_5] # E4, G4, D4, E4
var silent_hill_theme = [KEY_7, KEY_4, KEY_3, KEY_7] # G4, D4, C4, G4
var dark_souls_theme = [KEY_6, KEY_3, KEY_1, KEY_4] # F4, C4, A4, D4
var god_of_war_theme = [KEY_5, KEY_7, KEY_4, KEY_1] # E4, G4, D4, A4
var doom_eternal_theme = [KEY_3, KEY_7, KEY_1, KEY_6] # C4, G4, A4, F4
var zelda_lullaby = [KEY_7, KEY_4, KEY_5, KEY_3] # G4, D4, E4, C4
var to_zanarkand = [KEY_5, KEY_2, KEY_3, KEY_7] # E4, B4, C4, G4
var suteki_da_ne = [KEY_4, KEY_1, KEY_7, KEY_4] # D4, A4, G4, D4

func _input(event):
	if event is InputEventKey and event.pressed and event.keycode in notes:
		player.append(event.keycode)
		if player.size() > 20:
			player.pop_front()
		
		if has_sequence(player, trial):
			
			print("Trial matched!")
		
		audio_player.stream = notes[event.keycode]
		audio_player.play()

func has_sequence(big: Array, small: Array) -> bool:
	for i in big.size() - small.size() + 1:
		if big.slice(i, i + small.size()) == small:
			print(big.size() - small.size() + 1)
			return true
	return false
		
