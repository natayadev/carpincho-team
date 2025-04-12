extends CharacterBody2D


@export var speed = 80
var player = null  # Se completa al detectar al jugador

func _physics_process(delta):
	if player:
		var direction = (player.global_position - global_position).normalized()
		velocity = direction * speed
		move_and_slide()
	else:
		velocity = Vector2.ZERO


func _on_detection_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("players"):
		player = body


#func _on_detection_area_body_exited(body: Node2D) -> void:
	#if body == player:
		#player = null
