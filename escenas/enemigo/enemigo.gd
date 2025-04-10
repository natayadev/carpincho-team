extends CharacterBody2D


signal clicked(enemy)
@export var health: int = 100
@onready var area = $Area2D

func _ready():
	area.input_event.connect(_on_input_event)

func _on_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.pressed:
		emit_signal("clicked", self)  # Enviar señal con referencia al enemigo
		
func take_damage(amount: int):
	health -= amount
	print("-", amount)
	if health <= 0:
		queue_free()  # Eliminar al enemigo cuando su vida llegue a 0
