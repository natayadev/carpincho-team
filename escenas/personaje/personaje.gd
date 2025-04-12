extends CharacterBody2D

@export var health = 1000
@export var speed: float = 400
@export var attack_speed: float = 600  # Velocidad del ataque (tackle)
@export var attack_distance: float = 100  # Distancia mínima para impactar al enemigo

var target: Vector2
var enemy_target: Node2D = null
var is_attacking: bool = false

@onready var animated_sprite = $AnimatedSprite2D

func _process(delta):
	if velocity.length() > 0.1:
		if animated_sprite.animation != "walk":
			animated_sprite.play("walk")
			
	else:
		if animated_sprite.animation != "idle":
			animated_sprite.play("idle")
	if velocity.x < -10:
		animated_sprite.flip_h = true  # Mira a la izquierda
	elif velocity.x > 10:
		animated_sprite.flip_h = false  # Mira a la derecha

func _ready():
	target = global_position  # Inicializar el target en la posición actual

func _input(event):
	if event is InputEventMouseButton and event.pressed:
		var clicked_object = get_clicked_object(event.position)
		if clicked_object and clicked_object.is_in_group("enemigos"):  # Si el clic fue sobre un enemigo
			attack(clicked_object)
		else:
			stop_attack()
			target = get_global_mouse_position()

func _physics_process(delta):
	if is_attacking and enemy_target:
		var direction = (enemy_target.global_position - global_position).normalized()
		velocity = direction * attack_speed

		if global_position.distance_to(enemy_target.global_position) < attack_distance:
			is_attacking = false
			velocity = Vector2.ZERO
			if enemy_target.has_method("take_damage"):
				enemy_target.take_damage(20)
				print("Ataque realizado")

	else:
		var direction = (target - global_position).normalized()
		velocity = direction * speed if global_position.distance_to(target) > 10 else Vector2.ZERO

	move_and_slide()

func attack(enemy: Node2D):
	""" Ordena atacar a un enemigo. """
	enemy_target = enemy
	is_attacking = true
	
	
	
func stop_attack():
	""" Detiene el ataque y permite moverse de nuevo. """
	is_attacking = false
	enemy_target = null


func get_clicked_object(mouse_pos) -> Node2D:
	""" Devuelve el objeto en la posición del clic, si existe. """
	var space_state = get_world_2d().direct_space_state
	var query = PhysicsPointQueryParameters2D.new()
	query.position = mouse_pos
	var result = space_state.intersect_point(query)
	
	if result.size() > 0:
		return result[0].collider
	return null
	
	
	#recibir daño
	
	# Método para recibir daño
func take_damage(amount):
	health -= amount
	print("Salud del jugador: ", health)  # Para depuración
	if health <= 0:
		die()

# Método para manejar la muerte del jugador
func die():
	queue_free()
