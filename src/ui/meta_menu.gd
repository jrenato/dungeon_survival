extends CanvasLayer

@onready var grid_container: GridContainer = $MarginContainer/GridContainer

@export var upgrades : Array[MetaUpgrade] = []

var meta_card_scene : PackedScene = preload("res://src/ui/meta_upgrade_card.tscn")


func _ready() -> void:
	for upgrade in upgrades:
		var meta_card : MetaUpgradeCard = meta_card_scene.instantiate() as MetaUpgradeCard
		grid_container.add_child(meta_card)
		meta_card.set_meta_upgrade(upgrade)

