extends Node

const SPAWN_RADIUS : int = 400

@export var enemy_scene : PackedScene
@export var arena_manager : ArenaManager

@onready var timer: Timer = %Timer

var base_spawn_time = 0


func _ready() -> void:
	base_spawn_time = timer.wait_time
	timer.timeout.connect(on_timer_timeout)
	arena_manager.arena_difficulty_changed.connect(_on_arena_difficulty_changed)


func on_timer_timeout() -> void:
	timer.start()

	var player : Player = get_tree().get_first_node_in_group("player") as Player
	if player == null:
		return

	var random_direction : Vector2 = Vector2.RIGHT.rotated(randf_range(0, TAU))
	var spawn_position : Vector2 = player.global_position + (random_direction * SPAWN_RADIUS)

	var enemy : Enemy = enemy_scene.instantiate() as Enemy
	var entities_layer = get_tree().get_first_node_in_group("entities_layer")
	if entities_layer != null:
		enemy.global_position = spawn_position
		entities_layer.add_child(enemy)


func _on_arena_difficulty_changed(arena_difficulty : int) -> void:
	var time_off : float = (0.1 / 12) * arena_difficulty
	time_off = min(time_off, 0.7)
	print("time_off: ", time_off)
	timer.wait_time = base_spawn_time - time_off
