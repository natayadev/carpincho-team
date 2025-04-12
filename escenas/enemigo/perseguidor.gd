extends CharacterBody2D

signal clicked(enemy)

@export var health: int = 100
@export var speed = 60
var player = null  # Se completa al detectar al jugador

@onready var click_area = $Area2D 


func _ready():
	click_area.input_event.connect(_on_input_event)
	
	
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
		
		

func _on_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.pressed:
		emit_signal("clicked", self)


func take_damage(amount: int):
	health -= amount
	print("Enemigo recibió:", amount, "- Vida restante:", health)
	if health <= 0:
		queue_free()
