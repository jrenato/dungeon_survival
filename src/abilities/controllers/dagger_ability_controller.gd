extends Node


@export var dagger_ability : PackedScene


func _ready() -> void:
	# Right click and select "Access as Unique Name" to access a node using %
	%Timer.timeout.connect(_on_timer_timeout)


func _on_timer_timeout() -> void:
	var player = get_tree().get_first_node_in_group("player") as Player
	if player == null:
		return

	var dagger_instance : Node2D = dagger_ability.instantiate() as Node2D
	player.get_parent().add_child(dagger_instance)
	dagger_instance.global_position = player.global_position
