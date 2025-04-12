extends Area2D


var speed = 400
var direction = Vector2.ZERO

func set_direction(target_pos: Vector2):
	direction = (target_pos - global_position).normalized()

func _process(delta):
	position += direction * speed * delta

func _on_body_entered(body):
	if body.is_in_group("players"):
		body.take_damage(20)
		print("toco")
		queue_free()
		
#@export var speed: float = 500
#var direction: Vector2
#
#func _process(delta):
	#position += direction * speed * delta
#
#func set_direction(target_position: Vector2):
	#direction = (target_position - global_position).normalized()
