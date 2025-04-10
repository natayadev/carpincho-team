extends Area2D
@export var VelocidadBala = 10
func _ready() -> void:
	return
	
func _process(delta: float) -> void:
	movimientoBala()
	return
	
func movimientoBala() -> void:
	position.x -= 1 * VelocidadBala
	return
	
func destruirBala() -> void:
	queue_free()
