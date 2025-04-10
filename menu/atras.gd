extends Button

func _ready():
	pressed.connect(_on_atras_pressed)

func _on_atras_pressed() -> void:
	get_tree().change_scene_to_file("res://menu/menu.tscn")
