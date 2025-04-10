extends Button

func _ready():
	pressed.connect(_on_jugar_pressed)

func _on_jugar_pressed() -> void:
	get_tree().change_scene_to_file("res://main_loop/main.tscn")
