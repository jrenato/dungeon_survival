extends Node

@export var axe_ability_scene : PackedScene

@onready var timer: Timer = %Timer

var base_damage : int = 10
var additional_damage_percent: float = 1.0


func _ready() -> void:
	timer.timeout.connect(_on_timer_timeout)
	GameEvents.ability_upgraded.connect(_on_ability_upgraded)


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
	axe_ability.hitbox_component.damage = base_damage * additional_damage_percent


func _on_ability_upgraded(upgrade : AbilityUpgrade, current_upgrades : Dictionary) -> void:
	if upgrade.id == "axe_rate":
		pass
#		var percent_reduction : float = current_upgrades["sword_rate"]["level"] * 0.1
#		%Timer.wait_time = base_wait_time * (1 - percent_reduction)
#		%Timer.start()
	elif upgrade.id == "axe_damage":
		additional_damage_percent = 1 + (current_upgrades["axe_damage"]["level"] * 0.10)
