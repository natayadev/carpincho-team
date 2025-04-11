extends Node

@export var characters: Array[CharacterBody2D]  # Lista de personajes
@export var enemies_parent: Node2D  # Nodo que contiene a los enemigos

func _ready():
	for enemy in enemies_parent.get_children():
		if enemy.has_signal("clicked"):
			enemy.clicked.connect(_on_enemy_clicked)

func _on_enemy_clicked(enemy_target):
	for character in characters:
		if character.has_method("attack"):
			character.attack(enemy_target)  # Ordenar el ataque al enemigo clickeado
