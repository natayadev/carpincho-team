extends CharacterBody2D
signal hit

const SPEED = 200 # How fast the player will move (pixels/sec).
var screen_size # Size of the game window.

func _ready():
	screen_size = get_viewport_rect().size
	$ShieldSprite.play()
	#hide()


func _process(_delta):
	if velocity.length() > 0:
		$AnimatedSprite2D.play()
		if ($AudioStreamPlayer2D.has_stream_playback() == false):
			$AudioStreamPlayer2D.play()
	else:
		$AnimatedSprite2D.stop()
	
	#position += velocity * delta
	position = position.clamp(Vector2.ZERO, screen_size)

	if velocity.x != 0:
		$AnimatedSprite2D.animation = "walk"
		$AnimatedSprite2D.flip_v = false
		$AnimatedSprite2D.flip_h = velocity.x < 0
		
	elif velocity.y != 0:
		$AnimatedSprite2D.animation = "up"
		$AnimatedSprite2D.flip_v = false
		
	if (Input.is_action_just_pressed("attack") and $AttackDelay.is_stopped()):
		AtacarEnemigo()
	
	if (Input.is_action_pressed("shield")):
		Escudarse()
	else:
		$ShieldSprite.hide()
		
func _physics_process(_delta: float) -> void:
	
	var movimientoHorizontal := Input.get_axis("move_left", "move_right")
	var movimientoVertical := Input.get_axis("move_up", "move_down")
	if movimientoHorizontal || movimientoVertical:
		velocity.x = movimientoHorizontal * SPEED
		velocity.y = movimientoVertical * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.y = move_toward(velocity.y, 0, SPEED)

	move_and_slide()

func _on_body_entered(_body: Node2D) -> void:
	hide() # El jugador desaparece despues de ser golpeado
	hit.emit() #Emite la señal de que fue herido
	
	# Must be deferred as we can't change physics properties on a physics callback.
	$CollisionShape2D.set_deferred("disabled", true)
	
func Escudarse() -> void:
		$ShieldSprite.show()
	

func AtacarEnemigo() -> void:
	if($AttackHitbox.has_overlapping_areas()):
		var EnemigosEnArea = $AttackHitbox.get_overlapping_areas()
		for enemigo in EnemigosEnArea:
			print_debug("Ataco enemigo " + str(enemigo))
			enemigo.queue_free()
	pass
