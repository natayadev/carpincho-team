extends Button

func _ready():
	pressed.connect(_on_salir_pressed)

func _on_salir_pressed() -> void:
	get_tree().quit()
