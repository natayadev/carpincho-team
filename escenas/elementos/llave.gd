extends Area2D

signal puerta_llave


	


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("players"):
		emit_signal("puerta_llave")
		print("tocando")
		queue_free()
	
