
extends Area2D

var touching_player = null

func _process(delta):
	if touching_player:
		touching_player.heal(150 * delta)

func _on_body_entered(body):
	if body.is_in_group("player"): # importante: grupo singular "player"
		touching_player = body
		print("Jugador en zona termal")

func _on_body_exited(body):
	if body == touching_player:
		touching_player = null
		print("Jugador salió de zona termal")

#extends Area2D
#
#signal health_changed(health) 
#
#
#var touching_blue = false
#var target: Node2D = null
#
#func _process(delta: float) -> void:
#
#
	## Recuperación de vida 
	#
	#if touching_blue and target:
		#target.heal(150 * delta)
		#
#func _on_body_entered(body):
	#if body.is_in_group("players"):
		#target = body
		#touching_blue = true
		#print("Entré en zona azul")
#
#func _on_body_exited(body: Node2D) -> void:
	#if body == target:
		#target = null
		#touching_blue = false
		#print("Salí de zona azul")
#
#
#
#
#
	#
