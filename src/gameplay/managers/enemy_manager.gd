extends Node

const SPAWN_RADIUS : int = 400

@export var enemy_scene : PackedScene
@export var arena_manager : ArenaManager

@onready var timer: Timer = %Timer

var base_spawn_time = 0


func _ready() -> void:
	base_spawn_time = timer.wait_time
	timer.timeout.connect(_on_timer_timeout)
	arena_manager.arena_difficulty_changed.connect(_on_arena_difficulty_changed)


func get_spawn_position(player : Player) -> Vector2:
	var spawn_position = Vector2.ZERO
	var random_direction : Vector2 = Vector2.RIGHT.rotated(randf_range(0, TAU))

	for i in 4:
		spawn_position = player.global_position + (random_direction * SPAWN_RADIUS)

		var query_parameters = PhysicsRayQueryParameters2D.create(player.global_position, spawn_position, 1)
		var result = get_tree().root.world_2d.direct_space_state.intersect_ray(query_parameters)

		if result.is_empty():
			break
		else:
			random_direction = random_direction.rotated(deg_to_rad(90))

	return spawn_position


func _on_timer_timeout() -> void:
	timer.start()

	var player : Player = get_tree().get_first_node_in_group("player") as Player
	if player == null:
		return

	var enemy : Node2D = enemy_scene.instantiate() as Node2D

	var entities_layer = get_tree().get_first_node_in_group("entities_layer")
	if entities_layer != null:
		enemy.global_position = get_spawn_position(player)
		entities_layer.add_child(enemy)


func _on_arena_difficulty_changed(arena_difficulty : int) -> void:
	var time_off : float = (0.1 / 12) * arena_difficulty
	time_off = min(time_off, 0.7)
	timer.wait_time = base_spawn_time - time_off
