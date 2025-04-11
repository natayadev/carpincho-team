extends Node2D
var TamañoDeLaVentana
const OFFSET = 20 #Safezone para evitar generar enemigos en los margenes
@onready var player = get_parent().get_node("Player")

var ArrayDeEnemigos: Array = [
	"res://characters/aguara_guazu.tscn",
	"res://characters/yarara.tscn"
	]

func _ready() -> void:
	TamañoDeLaVentana = get_viewport_rect().size

func Spawn_(RutaAEscenaDelEnemigo: String):
	#TODO: Chequear la posicion del jugador para que los enemigos no spawneen encima de el
	
	var enemigo = load(RutaAEscenaDelEnemigo).instantiate()
	CalcularPosicionDeSpawn_(enemigo)
	get_tree().current_scene.add_child(enemigo)
	$SpawnTimer.start()
	print_debug("Spawneando 1 enemigo...")

func CalcularPosicionDeSpawn_(enemigo) -> void:
	enemigo.position.x = randi_range(OFFSET, TamañoDeLaVentana.x - OFFSET)
	enemigo.position.y = randi_range(OFFSET, TamañoDeLaVentana.y - OFFSET)
	#ChequearPosicion_(enemigo)

#TODO: Corregir que los enemigos spawneen sobre el personaje
func ChequearPosicion_(enemigo) -> void:
	var playerSafeZone = player.get_node("SafeZone")
	var NoDeseados = playerSafeZone.get_overlapping_bodies()
	if enemigo in NoDeseados:
		CalcularPosicionDeSpawn_(enemigo)
		print_debug("Recalculando posicion de spawn. SUPERPOSICION")
	else: return
	
	#if(enemigo.position.x >= margenes.x - OFFSET || enemigo.position.y <= margenes.x + OFFSET):
		#return false
	#else:
		#return true
	
func _on_spawn_timer_timeout() -> void:
	for x in randi_range(1, 5):
		Spawn_(ArrayDeEnemigos.pick_random())
