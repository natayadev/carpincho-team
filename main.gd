extends Node

var score

func game_over():
	$ScoreTimer.stop()
	$GameMusic.stop()
	$GameOverMusic.play()
	$HUD.show_game_over()

func new_game():
	score = 0
	$GameOverMusic.stop()
	$Player.start($StartPosition.position)
	$StartTimer.start()
	
func _ready():
	var custom_cursor = preload("res://art/Cursor.png")
	Input.set_custom_mouse_cursor(custom_cursor, Input.CURSOR_POINTING_HAND)
	$HUD/HealthBar.hide()
	$HUD/StaminaBar.hide()
	$GameMusic.play()
