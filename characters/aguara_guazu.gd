extends Area2D
@onready var player = get_parent().get_node("Player")
var Velocidad = 3
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func _process(_delta: float) -> void:
	SeguirJugador()
	pass
	
func SeguirJugador() -> void:
	var diferenciaDePosicion : Vector2 = self.position - player.position
	self.position -= diferenciaDePosicion.normalized() * Velocidad
	if ($AudioStreamPlayer2D.has_stream_playback() == false):
			$AudioStreamPlayer2D.play()
	
	
func AtacarJugador() -> void:
	#Codigo para atacar el personaje
	pass
	
