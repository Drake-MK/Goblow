extends Node2D

@onready var audio_player = $"../AudioStreamPlayer2D" # Reference to AudioStreamPlayer node
var notes = {
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
	KEY_0: preload("res://Asset/paino/C5.mp3")
}

# Magical melody: C3 - E3 - G3 - B3 - C4 - E4 - G4 - A4 - G4 - E4 - F4 - E4 - D4 - C4 - E4 - C4
var melody_keys = [KEY_C, KEY_B, KEY_M, KEY_X, KEY_3, KEY_5, KEY_7, KEY_1, KEY_7, KEY_5, KEY_6, KEY_5, KEY_4, KEY_3, KEY_5, KEY_3]
var is_playing = false  # Prevent overlapping playback

func _ready():
	pass

func _input(event):
	if event is InputEventKey and event.is_pressed() and event.keycode == KEY_ENTER and not is_playing:
		play_melody()

func play_melody():
	if is_playing:
		return
	is_playing = true
	for key in melody_keys:
		audio_player.stream = notes[key]
		audio_player.play()
		await get_tree().create_timer(0.3).timeout  # Fixed 0.3s delay for a magical pace
	is_playing = false
