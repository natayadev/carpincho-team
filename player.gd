extends Area2D

signal hit
signal health_changed(health)
signal stamina_changed(stamina)

var max_health = 1000
var health = 1000
var max_stamina = 1000
var stamina = 250
var touching_red = false
var touching_blue = false

@export var speed = 400
var screen_size

func _ready():
	screen_size = get_viewport_rect().size
	hide()

func _process(delta):
	var velocity = Vector2.ZERO
	if Input.is_action_pressed("move_right"):
		velocity.x += 1
	if Input.is_action_pressed("move_left"):
		velocity.x -= 1
	if Input.is_action_pressed("move_down"):
		velocity.y += 1
	if Input.is_action_pressed("move_up"):
		velocity.y -= 1

	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		$AnimatedSprite2D.play()
	else:
		$AnimatedSprite2D.stop()
	
	position += velocity * delta
	position = position.clamp(Vector2.ZERO, screen_size)

	if velocity.x != 0:
		$AnimatedSprite2D.animation = "walk"
		$AnimatedSprite2D.flip_v = false
		$AnimatedSprite2D.flip_h = velocity.x < 0
	elif velocity.y != 0:
		$AnimatedSprite2D.animation = "up"
		$AnimatedSprite2D.flip_v = false
		
	#Daño por tocar zona roja
	if touching_red:
		health -= 100 * delta
		health = max(health, 0)
		emit_signal("health_changed", health)
		if health == 0:
			_on_body_entered(self)

	# Recuperación de energía
	if touching_blue:
		stamina += 150 * delta
		stamina = min(stamina, max_stamina)
		emit_signal("stamina_changed", stamina)

func _on_body_entered(_body: Node2D) -> void:
	hide()
	hit.emit()
	$CollisionShape2D.set_deferred("disabled", true)

func start(pos):
	position = pos
	show()
	$CollisionShape2D.disabled = false
	
func _on_red_area_body_entered(body):
	if body == self:
		touching_red = true

func _on_red_area_body_exited(body):
	if body == self:
		touching_red = false

func _on_blue_area_body_entered(body):
	if body == self:
		touching_blue = true

func _on_blue_area_body_exited(body):
	if body == self:
		touching_blue = false
