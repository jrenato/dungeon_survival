extends CharacterBody2D
class_name Enemy


const MAX_SPEED : int = 40
@onready var health_component: HealthComponent = $HealthComponent
@onready var visuals: Node2D = $Visuals


func _process(delta: float) -> void:
	var direction : Vector2 = get_direction_to_player()
	velocity = direction * MAX_SPEED
	move_and_slide()
	
	var move_sign : int = sign(velocity.x)
	if move_sign != 0:
		visuals.scale = Vector2(-move_sign, 1)


func get_direction_to_player() -> Vector2:
	var player : Player = get_tree().get_first_node_in_group("player") as Player
	if player != null:
		return (player.global_position - global_position).normalized()

	return Vector2.ZERO
