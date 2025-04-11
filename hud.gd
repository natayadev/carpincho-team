extends CanvasLayer

signal start_game
var is_muted := false

func show_game_over():
	$StartButton.show()

func _on_start_button_pressed():
	$StartButton.hide()
	$ExitButton.hide()
	$MuteButton.hide()
	$Background.hide()
	$Title.hide()
	$HealthBar.show()
	$StaminaBar.show()	
	start_game.emit()
	
func _on_mute_button_pressed() -> void:
	is_muted = !is_muted
	var master_bus := AudioServer.get_bus_index("Master")
	AudioServer.set_bus_mute(master_bus, is_muted)

func _on_exit_button_pressed() -> void:
	get_tree().quit()

func _on_player_health_changed(health: Variant) -> void:
	pass
