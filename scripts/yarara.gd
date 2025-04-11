extends Area2D

class_name Enemigo_Yarara
signal spawnBala


func _ready() -> void:
	return
	
func spawn_bala() -> void:
	var bala = load("res://characters/bola_veneno.tscn").instantiate()
	add_child(bala)
	spawnBala.emit()
	

func _on_time_between_shots_timeout() -> void:
	spawn_bala()
	$TimeBetweenShots.start()
