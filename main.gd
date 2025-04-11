extends Node

var score

func game_over():
	$ScoreTimer.stop()
	$GameMusic.stop()
	$GameOverMusic.play()
	$HUD.show_game_over()

func new_game():
	#score = 0
	#$GameOverMusic.stop()
	#$Player.start($StartPosition.position)
	#$StartTimer.start()
	get_tree().change_scene_to_file("res://escenas/nivel 1.tscn")
	
func _on_player_health_changed(health):
	$HUD.update_health(int(health), $Player.max_health)

func _on_player_stamina_changed(stamina):
	$HUD.update_stamina(int(stamina), $Player.max_stamina)
	
func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	var custom_cursor = load("res://art/Cursor.png")
	Input.set_custom_mouse_cursor(custom_cursor, Input.CURSOR_ARROW)

	$HUD/HealthBar.hide()
	$HUD/StaminaBar.hide()
	$HUD/Creditos.hide()
	$GameMusic.play()
	
	$HUD.update_health($Player.health, $Player.max_health)
	$HUD.update_stamina($Player.stamina, $Player.max_stamina)
	$Player.connect("health_changed", _on_player_health_changed)
	$Player.connect("stamina_changed", _on_player_stamina_changed)
