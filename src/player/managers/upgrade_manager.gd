extends Node
class_name UpgradeManager


@export var upgrade_pool : Array[AbilityUpgrade]
@export var experience_manager : ExperienceManager


var current_upgrades : Dictionary = {}


func _ready() -> void:
	experience_manager.level_up.connect(on_level_up)


func on_level_up(level : int) -> void:
	var chosen_upgrade : AbilityUpgrade = upgrade_pool.pick_random()

	if chosen_upgrade == null:
		return

	var has_upgrade : bool = current_upgrades.has(chosen_upgrade.id)
	if !has_upgrade:
		current_upgrades[chosen_upgrade.id] = {
			"resource": chosen_upgrade,
			"level": 1,
		}
	else:
		current_upgrades[chosen_upgrade.id]["level"] += 1
