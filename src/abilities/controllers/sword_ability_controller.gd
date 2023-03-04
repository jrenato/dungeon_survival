extends Node


@export var max_range : float = 100.0
@export var sword_ability : PackedScene


var damage : float = 5.0
var base_wait_time : float


func _ready() -> void:
	base_wait_time = %Timer.wait_time
	%Timer.timeout.connect(_on_timer_timeout)
	GameEvents.ability_upgraded.connect(_on_ability_upgraded)


func _on_timer_timeout() -> void:
	var player : Player = get_tree().get_first_node_in_group("player") as Player
	if player == null:
		return

	var enemies : Array = get_tree().get_nodes_in_group("enemy")
	enemies = enemies.filter(
		func(enemy : Node2D):
			return enemy.global_position.distance_squared_to(player.global_position) <= pow(max_range, 2)
	)

	if enemies.size() == 0:
		return

	enemies.sort_custom(
		func(a : Node2D, b : Node2D):
			var a_distance = a.global_position.distance_squared_to(player.global_position)
			var b_distance = b.global_position.distance_squared_to(player.global_position)
			return a_distance < b_distance
	)

	var sword_instance : SwordAbility = sword_ability.instantiate() as SwordAbility
	var foreground_layer = get_tree().get_first_node_in_group("foreground_layer")
	foreground_layer.add_child(sword_instance)
	sword_instance.hitbox_component.damage = damage

	sword_instance.global_position = enemies[0].global_position
	# Add some random offset to prevent enemies[0].global_position == sword_ability_instance.global_position
	sword_instance.global_position += Vector2.RIGHT.rotated(randf_range(0, TAU))

	var enemy_direction : Vector2 = enemies[0].global_position - sword_instance.global_position
	sword_instance.rotation = enemy_direction.angle()


func _on_ability_upgraded(upgrade : AbilityUpgrade, current_upgrades : Dictionary) -> void:
	if upgrade.id != "sword_rate":
		return

	var percent_reduction : float = current_upgrades["sword_rate"]["level"] * 0.1
	%Timer.wait_time = base_wait_time * (1 - percent_reduction)
	%Timer.start()
