extends Node2D

@onready var tank = $tank
@onready var intro = $Text/intro
@onready var timer = $Timer
@onready var ult = $Ult
@onready var thanks = $thanks
const THANKSuu = preload("res://thanks.tscn")
@onready var anim_main = $"anim main"
@onready var final = $final
@onready var audio_player = $keys  # AudioStreamPlayer node
var notes = {}

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
var creepy = keys.slice(3, 5)
var war = keys.slice(5, 8)
var peace = keys.slice(8, 11)

@onready var silent_hill_theme = $Music/SilentHillTheme
@onready var celeste_first_steps_ambient_cliff_music = $"Music/CelesteFirstSteps-AmbientCliffMusic"
@onready var undertale_ost_022_snowdin_town = $"Music/UndertaleOst022-SnowdinTown"
@onready var zelda_ocarina_of_time_zelda_s_lullaby = $"Music/ZeldaOcarinaOfTime-Zelda'sLullaby"
@onready var lavender_town = $Music/LavenderTown
@onready var god_of_war = $Music/GodOfWar
@onready var dark_souls = $Music/DarkSouls
@onready var celeste_first_steps_ambient_cliff_music_2 = $"Music/CelesteFirstSteps-AmbientCliffMusic2"

var music_tracks = []

var player = []
var random_threshold = 8

func _ready():
	ult.start(30)
	god_of_war.play()
	print(keys, sleepy, creepy, war, peace)
	music_tracks = [
	silent_hill_theme,
	celeste_first_steps_ambient_cliff_music,
	undertale_ost_022_snowdin_town,
	zelda_ocarina_of_time_zelda_s_lullaby,
	lavender_town,
	god_of_war,
	dark_souls,
	celeste_first_steps_ambient_cliff_music_2
]
	# Debug for null tracks
	for i in music_tracks.size():
		if music_tracks[i] == null:
			print("Track at index ", i, " is null!")

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

		var melody_matched = false
		for name in melodies.keys():
			if has_sequence(player, melodies[name]):
				melody_matched = true
				stop_all_music()
				if name in war:
					intro.text = "You Made IT WORSE"
					anim_main.play("at_war")
					random_war()
					refresh()
				elif name in peace:
					random_peace()
					if anim_main.current_animation == 'at_idle':
						intro.text = "Thanks, my lord"
						anim_main.play("at_peace")
						thank()
						refresh()
				elif name in creepy:
					random_creepy()
					intro.text = "WHAT THE HELL IS THIS?"
					anim_main.play("at_death")
					refresh()
				elif name in sleepy:
					random_sleepy()
					intro.text = "THEY ARE LISTENING"
					anim_main.play("at_idle")
					refresh()
				player.clear()
				break

		if not melody_matched and player.size() >= random_threshold:
			intro.text = "You Made IT WORSE"
			anim_main.play("at_war")
			tank.tank_color()
			refresh()
			player.clear()

		audio_player.stream = notes[event.keycode]
		audio_player.play()

	if Input.is_action_just_pressed("ui_down"):
		intro.text = "# sleepy   # 🕸️ Creepy Themes\nSnowdin Theme → 7, 3, 4, 7      Lavender Town → 5, 7, 4, 5\nCeleste (Easy) → 3, 7, 1, 6         ! Silent Hill → 7, 4, 3, 7\nCeleste (Ambient) → 1, 6, 3, 7\n\n# ⚔️ War Themes                  🕊️ Peace Themes\nDoom Eternal → 3, 7, 1, 6         To Zanarkand → 5, 2, 3, 7\nZelda Lullaby → 7, 4, 5, 3        Suteki Da Ne → 4, 1, 7, 4"

func has_sequence(big: Array, small: Array) -> bool:
	for i in big.size() - small.size() + 1:
		if big.slice(i, i + small.size()) == small:
			return true
	return false

func refresh():
	timer.start(1)

func _on_timer_timeout():
	intro.text = ""

func _on_ult_timeout():
	intro.text = "Master Sorry if you can't do it, Press UP to view the combinations"
	refresh()

func thank():
	thanks.start(5)
	celeste_first_steps_ambient_cliff_music.play()

func _on_thanks_timeout():
	get_tree().change_scene_to_file("res://thanks.tscn")

func stop_all_music():
	for track in music_tracks:
		if track != null and track.playing:
			track.stop()

func random_war():
	stop_all_music()
	var a = randi_range(0, 1)
	if a == 0:
		god_of_war.play()
	else:
		dark_souls.play()

func random_peace():
	stop_all_music()
	var a = randi_range(0, 1)
	if a == 0:
		celeste_first_steps_ambient_cliff_music.play()
	else:
		zelda_ocarina_of_time_zelda_s_lullaby.play()

func random_creepy():
	stop_all_music()
	var a = randi_range(0, 1)
	if a == 0:
		lavender_town.play()
	else:
		silent_hill_theme.play()

func random_sleepy():
	stop_all_music()
	undertale_ost_022_snowdin_town.play()


func _on_button_pressed():
	pass # Replace with function body.
	get_tree().reload_current_scene()
