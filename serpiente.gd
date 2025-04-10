extends CharacterBody2D

class_name Enemigo_Serpiente
signal spawnBala


func _ready() -> void:
	return

func _process(delta: float) -> void:
	return

	
func spawn_bala() -> void:
	var bala = load("res://bola_veneno.tscn").instantiate()
	add_child(bala)
	spawnBala.emit()
	


func _on_time_between_shots_timeout() -> void:
	spawn_bala()
	$TimeBetweenShots.start()
