extends Camera2D

var target_position : Vector2 = Vector2.ZERO


func _ready() -> void:
	make_current()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	acquire_target()
	if target_position:
		global_position = global_position.lerp(target_position, 1.0 - exp(-delta * 10))


func acquire_target() -> void:
	var player_nodes = get_tree().get_nodes_in_group("player")
	if player_nodes.size() > 0:
		var player : Player = player_nodes[0] as Player
		target_position = player.global_position
