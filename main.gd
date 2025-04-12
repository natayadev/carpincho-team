extends Node

var score
var player_died := false

@onready var game_music = $GameMusic
@onready var game_over_music = $GameOverMusic

func new_game():
	player_died = false
	get_tree().change_scene_to_file("res://escenas/nivel.tscn")

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	var custom_cursor = load("res://art/Cursor.png")
	Input.set_custom_mouse_cursor(custom_cursor, Input.CURSOR_ARROW)

	if player_died:
		game_music.stop()
		game_over_music.play()
	else:
		game_over_music.stop()
		game_music.play()
