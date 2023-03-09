extends CanvasLayer
class_name MetaUpgradesMenu

@onready var grid_container: GridContainer = %GridContainer
@onready var back_button: Button = %BackButton

@export var upgrades : Array[MetaUpgrade] = []

var meta_card_scene : PackedScene = preload("res://src/ui/meta_upgrade_card.tscn")


func _ready() -> void:
	back_button.pressed.connect(_on_back_button_pressed)

	for child in grid_container.get_children():
		child.queue_free()

	for upgrade in upgrades:
		var meta_card : MetaUpgradeCard = meta_card_scene.instantiate() as MetaUpgradeCard
		grid_container.add_child(meta_card)
		meta_card.set_meta_upgrade(upgrade)


func _on_back_button_pressed() -> void:
#	ScreenTransition.transition_to_scene("res://src/ui/main_menu.tscn")
	get_tree().change_scene_to_file("res://src/ui/main_menu.tscn")
