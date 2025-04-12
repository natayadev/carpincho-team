extends Control

func _input(event):
	if event is InputEventMouseButton and event.pressed:
		get_tree().change_scene_to_file("res://main.tscn")
