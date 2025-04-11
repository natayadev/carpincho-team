extends CanvasLayer

signal start_game
var is_muted := false

func show_game_over():
	$StartButton.show()
	$ExitButton.show()
	$CreditsButton.show()
	$MuteButton.show()
	$Title.show()
	$HealthBar.hide()
	$StaminaBar.hide()
	$Background.show()
	$Creditos.hide()

func _on_start_button_pressed():
	$StartButton.hide()
	$ExitButton.hide()
	$MuteButton.hide()
	$CreditsButton.hide()
	$Background.hide()
	$Title.hide()
	$Creditos.hide()
	$HealthBar.show()
	$StaminaBar.show()	
	start_game.emit()
	
func _on_mute_button_pressed() -> void:
	is_muted = !is_muted
	var master_bus := AudioServer.get_bus_index("Master")
	AudioServer.set_bus_mute(master_bus, is_muted)

func _on_exit_button_pressed() -> void:
	get_tree().quit()
	
func update_health(current: int, max: int) -> void:
	$HealthBar.value = current
	$HealthBar/HealthLabel.text = "%d / %d" % [current, max]

func update_stamina(current: int, max: int) -> void:
	$StaminaBar.value = current
	$StaminaBar/StaminaLabel.text = "%d / %d" % [current, max]

func _on_credits_button_pressed() -> void:
	$Title.hide()
	$Creditos.show()
