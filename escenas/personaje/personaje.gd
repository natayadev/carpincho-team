extends CharacterBody2D

@export var speed: float = 400
@export var attack_speed: float = 600
@export var attack_distance: float = 100

@export var max_health = 1000
@export var max_stamina = 1000

@onready var animated_sprite = $AnimatedSprite2D

signal health_changed(health)
signal stamina_changed(stamina)

var health: int = max_health
var stamina: int = max_stamina

var target: Vector2
var enemy_target: Node2D = null
var is_attacking: bool = false

func _ready():
	target = global_position
	add_to_group("player")

func _process(delta):
	if velocity.length() > 0.1:
		if animated_sprite.animation != "walk":
			animated_sprite.play("walk")
	else:
		if animated_sprite.animation != "idle":
			animated_sprite.play("idle")

	if velocity.x < -10:
		animated_sprite.flip_h = true
	elif velocity.x > 10:
		animated_sprite.flip_h = false

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

func _input(event):
	if event is InputEventMouseButton and event.pressed:
		var clicked_object = get_clicked_object(event.position)
		if clicked_object and clicked_object.is_in_group("enemigos"):
			attack(clicked_object)
		else:
			stop_attack()
			target = get_global_mouse_position()

func attack(enemy: Node2D):
	enemy_target = enemy
	is_attacking = true

func stop_attack():
	is_attacking = false
	enemy_target = null

func get_clicked_object(mouse_pos) -> Node2D:
	var space_state = get_world_2d().direct_space_state
	var query = PhysicsPointQueryParameters2D.new()
	query.position = mouse_pos
	var result = space_state.intersect_point(query)

	if result.size() > 0:
		return result[0].collider
	return null

# Recibir daño
func take_damage(amount: int):
	health = clamp(health - amount, 0, max_health)
	print("Salud del jugador: ", health)
	emit_signal("health_changed", health)
	if health <= 0:
		die()

func use_stamina(amount: int):
	stamina = clamp(stamina - amount, 0, max_stamina)
	emit_signal("stamina_changed", stamina)
	
func heal(amount: float) -> void:
	health = min(health + amount, max_health)
	emit_signal("health_changed", health)

func die():
	queue_free()
	get_tree().change_scene_to_file("res://main.tscn")
