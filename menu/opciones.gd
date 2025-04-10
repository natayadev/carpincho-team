extends Button

func _ready():
	pressed.connect(_on_opciones_pressed)

func _on_opciones_pressed() -> void:
	get_tree().change_scene_to_file("res://menu/opciones.tscn")
