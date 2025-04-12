extends CharacterBody2D

signal clicked(enemy)

@export var health: int = 100
@export var attack_range: float = 300  # Distancia de disparo
@export var fire_rate: float = 2     # Tiempo entre disparos

var target: Node2D = null

@onready var click_area = $Area2D              # Para clics del jugador
@onready var detection_area = $DetectionArea   # Para detectar jugadores cercanos
@onready var timer = $Timer

@onready var sprite = $Sprite
var textures = [
	preload("res://art/yarara_sprites_v4.png"),
	preload("res://art/yarara_sprites_v4-2.png")
]

var texture_index = 0

func _ready():
	click_area.input_event.connect(_on_input_event)
	timer.wait_time = fire_rate
	timer.start()
	

func _input(event):
	# esto no es necesario acá, se maneja con _on_input_event
	pass

func _on_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.pressed:
		emit_signal("clicked", self)

func take_damage(amount: int):
	health -= amount
	print("Enemigo recibió:", amount, "- Vida restante:", health)
	if health <= 0:
		queue_free()

func _process(_delta):
	if target and global_position.distance_to(target.global_position) <= attack_range:
		look_at(target.global_position)

func _on_detection_area_body_entered(body):
	if body.is_in_group("players"):
		target = body
		print("Entró algo:", body.name)

func _on_detection_area_body_exited(body):
	if body == target:
		target = null
		sprite.texture = textures[0]

func _on_timer_timeout():
	if target and global_position.distance_to(target.global_position) <= attack_range:
		shoot()

func shoot():
	var bullet = preload("res://bala.tscn").instantiate()
	bullet.global_position = global_position
	bullet.set_direction(target.global_position)
	get_tree().current_scene.add_child(bullet)
	sprite.texture = textures[1]
	
		
		
	# Alternar entre las texturas
	#texture_index = (texture_index + 1) % textures.size()

	
	



# Lista de texturas para el cambio (puedes tener varias)


# Variable para alternar las texturas







#extends CharacterBody2D
#
#
#signal clicked(enemy)
#@export var health: int = 100
#@onready var area = $Area2D
#
#@export var attack_range: float = 300  # Distancia de disparo
#@export var fire_rate: float = 1.5  # Tiempo entre disparos
#
#@onready var timer = $Timer
#var target = null
#
#func _ready():
	#area.input_event.connect(_on_input_event)
	#timer.wait_time = fire_rate
	#timer.start()
	#
#
#func _on_input_event(viewport, event, shape_idx):
	#if event is InputEventMouseButton and event.pressed:
		#emit_signal("clicked", self)  # Enviar señal con referencia al enemigo
		#
#func take_damage(amount: int):
	#health -= amount
	#print("-", amount)
	#if health <= 0:
		#queue_free()  # Eliminar al enemigo cuando su vida llegue a 0
		#
		#
#
#
## disparar balas
	#
#
#func _process(_delta):
	#if target and global_position.distance_to(target.global_position) <= attack_range:
		#look_at(target.global_position)  # Gira hacia el objetivo
#
#func _on_detection_area_body_entered(body):
	#if body.is_in_group("players"):
		#target = body
#
#func _on_detection_area_body_exited(body):
	#if body == target:
		#target = null
#
#func _on_timer_timeout():
	#if target and global_position.distance_to(target.global_position) <= attack_range:
		#shoot()
#
#func shoot():
	#var bullet = preload("res://bala.tscn").instantiate()
	#bullet.global_position = global_position
	#bullet.set_direction(target.global_position)
	#get_parent().add_child(bullet)
#
#
#func _on_area_2d_2_body_entered(body: Node2D) -> void:
	#if body.is_in_group("players"):
		#target = body
