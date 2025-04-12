extends CharacterBody2D

signal clicked(enemy)

@export var health: int = 100
@export var speed = 60
var player = null  # Se completa al detectar al jugador

@onready var click_area = $Area2D 
@onready var animated_sprite = $run

@export var damage_amount: int = 20
@export var damage_interval: float = 1.0  # segundos entre cada golpe
@onready var damage_timer = $DamageTimer
	
			


func _ready():
	click_area.input_event.connect(_on_input_event)
	damage_timer.timeout.connect(_on_damage_timer_timeout)
	damage_timer.wait_time = damage_interval

	
	
func _physics_process(delta):
	if player:
		var direction = (player.global_position - global_position).normalized()
		velocity = direction * speed
		move_and_slide()
	else:
		velocity = Vector2.ZERO
		
	if velocity.length() > 0.1:
		if animated_sprite.animation != "run":
			animated_sprite.play("run")
	else:
		if animated_sprite.animation != "idle":
			animated_sprite.play("idle")
	if velocity.x < -10:
		animated_sprite.flip_h = false   # Mira a la izquierda
	elif velocity.x > 10:
		animated_sprite.flip_h = true # Mira a la derecha



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
		
		

#
#func _on_area_2d_body_entered(body: Node2D) -> void:
	#if body.is_in_group("players"):
		#body.take_damage(20)
		#print("toco")
		
		# --- Daño continuo cuando el jugador entra/sale ---
func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("players"):
		player = body
		damage_timer.start()


func _on_area_2d_body_exited(body: Node2D) -> void:
	if body == player:
		damage_timer.stop()


func _on_damage_timer_timeout():
	if player and player.is_inside_tree():
		if player.has_method("take_damage"):
			player.take_damage(damage_amount)
			print("Enemigo hizo daño al jugador")
