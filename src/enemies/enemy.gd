extends CharacterBody2D
class_name Enemy


const MAX_SPEED : float = 75.0


func _process(delta: float) -> void:
	var direction : Vector2 = get_direction_to_player()
	velocity = direction * MAX_SPEED
	move_and_slide()


func get_direction_to_player() -> Vector2:
	var player : Player = get_tree().get_first_node_in_group("player") as Player
	if player != null:
		return (player.global_position - global_position).normalized()

	return Vector2.ZERO
