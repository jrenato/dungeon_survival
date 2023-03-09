extends Node

const BASE_RANGE : float = 100.0
const BASE_DAMAGE : float = 15.0 

@onready var timer: Timer = %Timer

@export var anvil_ability_scene : PackedScene


func _ready() -> void:
	timer.timeout.connect(_on_timer_timeout)


func _on_timer_timeout() -> void:
	var player : Player = get_tree().get_first_node_in_group("player") as Player
	if player == null:
		return

	var random_direction : Vector2 = Vector2.RIGHT.rotated(randf_range(0, TAU))
	var spawn_position = player.global_position + (random_direction * randf_range(0, BASE_RANGE))
	var aditional_check_offset : Vector2 = random_direction * 20

	var query_parameters = PhysicsRayQueryParameters2D.create(player.global_position, spawn_position + aditional_check_offset, 1)
	var result = get_tree().root.world_2d.direct_space_state.intersect_ray(query_parameters)

	if not result.is_empty():
		spawn_position = result["position"]

	var anvil_ability : AnvilAbility = anvil_ability_scene.instantiate() as AnvilAbility
	get_tree().get_first_node_in_group("foreground_layer").add_child(anvil_ability)
	anvil_ability.global_position = spawn_position
	anvil_ability.hitbox_component.damage = BASE_DAMAGE
