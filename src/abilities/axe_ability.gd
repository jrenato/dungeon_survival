extends Node2D
class_name AxeAbility

const MAX_RADIUS : float = 100.0

@onready var hitbox_component: HitboxComponent = $HitboxComponent

var base_rotation : Vector2 = Vector2.RIGHT


func _ready() -> void:
	var tween : Tween = create_tween()
	base_rotation = Vector2.RIGHT.rotated(randf_range(0, TAU))
	tween.tween_method(tween_method, 0.0, 2.0, 3)
	tween.tween_callback(queue_free)


func tween_method(rotations : float) -> void:
	var percent : float = (rotations / 2)
	var current_radius : float = percent * MAX_RADIUS
	var current_direction : Vector2 = base_rotation.rotated(rotations * TAU)

	var player : Player = get_tree().get_first_node_in_group("player") as Player
	if player == null:
		return

	global_position = player.global_position + (current_direction * current_radius)
