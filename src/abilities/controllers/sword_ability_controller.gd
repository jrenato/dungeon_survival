extends Node

@export var max_range : float = 100.0
@export var sword_ability : PackedScene

var damage : float = 5.0

func _ready() -> void:
	# Right click and select "Access as Unique Name" to access a node using %
	%Timer.timeout.connect(_on_timer_timeout)


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

	var sword_instance : SwordAbility = sword_ability.instantiate() as  SwordAbility
	player.get_parent().add_child(sword_instance)
	sword_instance.hitbox_component.damage = damage

	sword_instance.global_position = enemies[0].global_position
	# Add some random offset to prevent enemies[0].global_position == sword_ability_instance.global_position
	sword_instance.global_position += Vector2.RIGHT.rotated(randf_range(0, TAU))

	var enemy_direction : Vector2 = enemies[0].global_position - sword_instance.global_position
	sword_instance.rotation = enemy_direction.angle()
