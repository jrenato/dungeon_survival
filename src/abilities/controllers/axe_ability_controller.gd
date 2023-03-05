extends Node

@export var axe_ability_scene : PackedScene

@onready var timer: Timer = %Timer

var damage : int = 10


func _ready() -> void:
	timer.timeout.connect(_on_timer_timeout)


func _on_timer_timeout() -> void:
	var player : Player = get_tree().get_first_node_in_group("player") as Player
	if player == null:
		return

	var foreground_layer = get_tree().get_first_node_in_group("foreground_layer")
	if foreground_layer == null:
		return

	var axe_ability : AxeAbility = axe_ability_scene.instantiate() as AxeAbility
	foreground_layer.add_child(axe_ability)
	axe_ability.global_position = player.global_position
	axe_ability.hitbox_component.damage = damage
