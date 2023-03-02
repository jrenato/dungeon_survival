extends CharacterBody2D
class_name Enemy


const MAX_SPEED : int = 40
@onready var health_component: HealthComponent = $HealthComponent


func _ready() -> void:
	%Area2D.area_entered.connect(on_area_entered)


func _process(delta: float) -> void:
	var direction : Vector2 = get_direction_to_player()
	velocity = direction * MAX_SPEED
	move_and_slide()


func get_direction_to_player() -> Vector2:
	var player : Player = get_tree().get_first_node_in_group("player") as Player
	if player != null:
		return (player.global_position - global_position).normalized()

	return Vector2.ZERO


func on_area_entered(area : Area2D) -> void:
	health_component.damage(5)
