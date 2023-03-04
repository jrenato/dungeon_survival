extends Node

const SPAWN_RADIUS : int = 400

@export var enemy_scene : PackedScene


func _ready() -> void:
	%Timer.timeout.connect(on_timer_timeout)


func on_timer_timeout() -> void:
	var player : Player = get_tree().get_first_node_in_group("player") as Player
	if player == null:
		return

	var random_direction : Vector2 = Vector2.RIGHT.rotated(randf_range(0, TAU))
	var spawn_position : Vector2 = player.global_position + (random_direction * SPAWN_RADIUS)

	var enemy : Enemy = enemy_scene.instantiate() as Enemy
	var entities_layer = get_tree().get_first_node_in_group("entities_layer")
	if entities_layer != null:
		entities_layer.add_child(enemy)
		enemy.global_position = spawn_position
