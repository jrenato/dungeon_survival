extends Node2D

@onready var area_2d: Area2D = %Area2D
@onready var collision_shape_2d: CollisionShape2D = $Area2D/CollisionShape2D


func _ready() -> void:
	area_2d.area_entered.connect(on_area_entered)


func tween_collect(percent: float, start_position: Vector2) -> void:
	var player : Player = get_tree().get_first_node_in_group("player")
	if player == null:
		return

	global_position = start_position.lerp(player.global_position, percent)
	var direction_from_start : Vector2 = global_position - start_position
	rotation_degrees = rad_to_deg(direction_from_start.angle()) + 90


func collect() -> void:
	GameEvents.emit_experience_vial_collected(1)
	queue_free()


func disable_collision() -> void:
	collision_shape_2d.disabled = true


func on_area_entered(other_area: Area2D) -> void:
	Callable(disable_collision).call_deferred()

	var tween : Tween = create_tween()
	# Check https://easings.net/en
	tween.tween_method(tween_collect.bind(global_position), 0.0, 1.0, 0.5)\
		.set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_BACK)
	tween.tween_callback(collect)
