extends Node
class_name UpgradeManager


@export var upgrade_pool : Array[AbilityUpgrade]
@export var experience_manager : ExperienceManager
@export var upgrade_screen_scene : PackedScene


var current_upgrades : Dictionary = {}


func _ready() -> void:
	experience_manager.level_up.connect(_on_level_up)


func apply_upgrade(upgrade : AbilityUpgrade) -> void:
	var has_upgrade : bool = current_upgrades.has(upgrade.id)
	if !has_upgrade:
		current_upgrades[upgrade.id] = {
			"resource": upgrade,
			"level": 1,
		}
	else:
		current_upgrades[upgrade.id]["level"] += 1

	if upgrade.max_level > 0:
		var current_level : int = current_upgrades[upgrade.id]["level"]
		if current_level == upgrade.max_level:
			upgrade_pool = upgrade_pool.filter(
				func(pool_upgrade): return pool_upgrade.id != upgrade.id
			)

	GameEvents.emit_ability_upgraded(upgrade, current_upgrades)


func pick_upgrades() -> Array[AbilityUpgrade]:
	var chosen_upgrades : Array[AbilityUpgrade] = []
	var filtered_upgrades = upgrade_pool.duplicate()

	for i in 2:
		if filtered_upgrades.size() == 0:
			break
		var chosen_upgrade : AbilityUpgrade = filtered_upgrades.pick_random()
		chosen_upgrades.append(chosen_upgrade)
		filtered_upgrades = filtered_upgrades.filter(
			func (upgrade): return upgrade.id != chosen_upgrade.id
		)

	return chosen_upgrades


func _on_level_up(level : int) -> void:
	var upgrade_screen_instance : UpgradeScreen = upgrade_screen_scene.instantiate()
	add_child(upgrade_screen_instance)

	var chosen_upgrades : Array[AbilityUpgrade] = pick_upgrades()

	upgrade_screen_instance.set_ability_upgrades(chosen_upgrades)
	upgrade_screen_instance.upgrade_selected.connect(_on_upgrade_selected)



func _on_upgrade_selected(upgrade : AbilityUpgrade) -> void:
	apply_upgrade(upgrade)
