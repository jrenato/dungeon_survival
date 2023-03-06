extends CanvasLayer
class_name UpgradeScreen


signal upgrade_selected(upgrade: AbilityUpgrade)


@onready var card_container: HBoxContainer = %CardContainer


@export var upgrade_card_scene : PackedScene


func _ready() -> void:
	get_tree().paused = true


func set_ability_upgrades(upgrades: Array[AbilityUpgrade]) -> void:
	var delay : float = 0
	for upgrade in upgrades:
		var card_instance : AbilityUpgradeCard = upgrade_card_scene.instantiate() as AbilityUpgradeCard
		card_container.add_child(card_instance)
		card_instance.set_ability_upgrade(upgrade)
		card_instance.play_enter(delay)
		card_instance.selected.connect(_on_upgrade_selected.bind(upgrade))
		delay += 0.2


func _on_upgrade_selected(upgrade: AbilityUpgrade) -> void:
	upgrade_selected.emit(upgrade)
	get_tree().paused = false
	queue_free()
