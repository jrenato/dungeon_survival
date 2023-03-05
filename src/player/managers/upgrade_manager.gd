extends Node
class_name UpgradeManager

@export var experience_manager : ExperienceManager
@export var upgrade_screen_scene : PackedScene


var upgrade_pool : WeightedTable = WeightedTable.new()
var current_upgrades : Dictionary = {}

var upgrade_axe : AbilityUpgrade = preload("res://resources/upgrades/axe.tres")
var upgrade_axe_damage : AbilityUpgrade = preload("res://resources/upgrades/axe_damage.tres")
var upgrade_sword_rate : AbilityUpgrade = preload("res://resources/upgrades/sword_rate.tres")
var upgrade_sword_damage : AbilityUpgrade = preload("res://resources/upgrades/sword_damage.tres")



func _ready() -> void:
	upgrade_pool.add_item(upgrade_axe, 10)
	upgrade_pool.add_item(upgrade_sword_rate, 10)
	upgrade_pool.add_item(upgrade_sword_damage, 10)

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
			upgrade_pool.remove_item(upgrade)

	update_upgrade_pool(upgrade)
	GameEvents.emit_ability_upgraded(upgrade, current_upgrades)


func update_upgrade_pool(chosen_upgrade : AbilityUpgrade) -> void:
	if chosen_upgrade.id == upgrade_axe.id:
		upgrade_pool.add_item(upgrade_axe_damage, 10)


func pick_upgrades() -> Array[AbilityUpgrade]:
	var chosen_upgrades : Array[AbilityUpgrade] = []

	for i in 2:
		if upgrade_pool.items.size() == chosen_upgrades.size():
			break
		var chosen_upgrade : AbilityUpgrade = upgrade_pool.pick_item(chosen_upgrades)
		chosen_upgrades.append(chosen_upgrade)

	return chosen_upgrades


func _on_level_up(level : int) -> void:
	var upgrade_screen_instance : UpgradeScreen = upgrade_screen_scene.instantiate()
	add_child(upgrade_screen_instance)

	var chosen_upgrades : Array[AbilityUpgrade] = pick_upgrades()

	upgrade_screen_instance.set_ability_upgrades(chosen_upgrades)
	upgrade_screen_instance.upgrade_selected.connect(_on_upgrade_selected)


func _on_upgrade_selected(upgrade : AbilityUpgrade) -> void:
	apply_upgrade(upgrade)
