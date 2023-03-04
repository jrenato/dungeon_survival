extends Node
class_name UpgradeManager


@export var upgrade_pool : Array[AbilityUpgrade]
@export var experience_manager : ExperienceManager
@export var upgrade_screen_scene : PackedScene


var current_upgrades : Dictionary = {}


func _ready() -> void:
	experience_manager.level_up.connect(on_level_up)


func on_level_up(level : int) -> void:
	var chosen_upgrade : AbilityUpgrade = upgrade_pool.pick_random()
	if chosen_upgrade == null:
		return
	var upgrade_screen_instance : UpgradeScreen = upgrade_screen_scene.instantiate()
	add_child(upgrade_screen_instance)
	upgrade_screen_instance.set_ability_upgrades([chosen_upgrade] as Array[AbilityUpgrade])
	upgrade_screen_instance.upgrade_selected.connect(_on_upgrade_selected)



func apply_upgrade(upgrade : AbilityUpgrade) -> void:
	var has_upgrade : bool = current_upgrades.has(upgrade.id)
	if !has_upgrade:
		current_upgrades[upgrade.id] = {
			"resource": upgrade,
			"level": 1,
		}
	else:
		current_upgrades[upgrade.id]["level"] += 1
	print(current_upgrades)


func _on_upgrade_selected(upgrade : AbilityUpgrade) -> void:
	apply_upgrade(upgrade)
