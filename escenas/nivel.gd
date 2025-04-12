extends Node2D

@onready var player = $players/personaje
@onready var health_bar = $UI/HealthBar
@onready var stamina_bar = $UI/StaminaBar
@onready var health_label = $UI/HealthBar/HealthLabel
@onready var stamina_label = $UI/StaminaBar/StaminaLabel

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	var custom_cursor = load("res://art/Cursor.png")
	Input.set_custom_mouse_cursor(custom_cursor, Input.CURSOR_ARROW)

	health_bar.max_value = player.max_health
	stamina_bar.max_value = player.max_stamina

	health_bar.value = player.health
	stamina_bar.value = player.stamina

	health_label.text = "%d / %d" % [player.health, player.max_health]
	stamina_label.text = "%d / %d" % [player.stamina, player.max_stamina]

	player.connect("health_changed", _on_player_health_changed)
	player.connect("stamina_changed", _on_player_stamina_changed)

func _on_player_health_changed(health):
	health_bar.value = int(health)
	health_label.text = "%d / %d" % [health, player.max_health]

func _on_player_stamina_changed(stamina):
	stamina_bar.value = int(stamina)
	stamina_label.text = "%d / %d" % [stamina, player.max_stamina]
