extends Button


func _ready():
	pressed.connect(_on_creditos_pressed)

func _on_creditos_pressed() -> void:
	get_tree().change_scene_to_file("res://menu/creditos.tscn")
