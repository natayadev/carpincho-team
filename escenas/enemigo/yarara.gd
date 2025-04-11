extends Area2D

class_name Enemigo_Yarara
signal spawnBala


func _ready() -> void:
	return
	
func spawn_bala() -> void:
	var bala = load("res://characters/bola_veneno.tscn").instantiate()
	add_child(bala) #TODO: Necesita ser cambiado a sibling, y pasar como argumento la posicion de la yarara que spawnea la bala
	spawnBala.emit()
	

func _on_time_between_shots_timeout() -> void:
	$AnimatedSprite2D.play()
	spawn_bala()
	$TimeBetweenShots.start()
