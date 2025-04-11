extends CharacterBody2D


@export var player: CharacterBody2D  # Referencia al personaje principal
@onready var nav_agent = $NavigationAgent2D
@onready var attack_timer = $Timer  # Temporizador para gestionar ataques

var speed = 100  # Velocidad del compañero

func _ready():
	nav_agent.path_desired_distance = 4.0
	nav_agent.target_desired_distance = 4.0
	attack_timer.wait_time = 1.5  # Tiempo entre ataques

func _physics_process(delta):
	if player:
		nav_agent.target_position = player.global_position  # Seguir al personaje
		
		if nav_agent.is_navigation_finished() == false:
			var direction = (nav_agent.get_next_path_position() - global_position).normalized()
			velocity = direction * speed
			move_and_slide()

func follow_target(target: Node2D):
	player = target  # Asignar el personaje como objetivo a seguir
