extends RigidBody2D
var VelocidadBala = 200
var impulso: Vector2
@onready var player = get_parent().get_parent().get_node("Player")

func _ready() -> void:
	$AnimatedSprite2D.play()
	ActualizarPosicionBala()
	print("lanze bola de veneno")
	
	
func ActualizarPosicionBala() -> void:
	#position -= 1 * VelocidadBala
	impulso.x = (get_parent().position.x - player.position.x) * -1
	impulso.y = (get_parent().position.y - player.position.y) * -1
	apply_central_impulse(impulso.normalized() * VelocidadBala)
	reparent(get_parent().get_parent())
	#apply_central_impulse(Vector2(0, 0))
	
func Destruir() -> void:
	queue_free()
	
