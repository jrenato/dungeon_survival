extends CharacterBody2D
class_name Player

const MAX_SPEED : float = 200.0


func _process(delta: float) -> void:
	var direction : Vector2 = get_movement_vector()
	velocity = direction * MAX_SPEED
	move_and_slide()


func get_movement_vector() -> Vector2:
	return Input.get_vector("move_left", 'move_right', "move_up", "move_down")
