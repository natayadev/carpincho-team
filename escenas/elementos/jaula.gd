extends Node2D

var llave = false

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("players") and llave == true:
		queue_free()


func _on_llave_puerta_llave() -> void:
	llave = true
	


func _on_llave_2_puerta_llave() -> void:
	llave = true


func _on_llave_3_puerta_llave() -> void:
	llave = true
