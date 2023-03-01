extends CharacterBody2D
class_name Player


const MAX_SPEED : int = 125
const ACCELERATION_SMOOTHING : int = 25

func _process(delta: float) -> void:
	var direction : Vector2 = get_movement_vector()
	var target_velocity : Vector2 = direction * MAX_SPEED

	#velocity = velocity.move_toward(target_velocity, delta)
	velocity = velocity.lerp(target_velocity, 1 - exp(-delta * ACCELERATION_SMOOTHING))

	move_and_slide()


func get_movement_vector() -> Vector2:
	return Input.get_vector("move_left", 'move_right', "move_up", "move_down")
