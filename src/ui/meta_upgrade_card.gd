extends PanelContainer
class_name MetaUpgradeCard

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var name_label: Label = %NameLabel
@onready var description_label: Label = %DescriptionLabel
@onready var progress_label: Label = $MarginContainer/VBoxContainer/VBoxContainer/ProgressLabel
@onready var progress_bar: ProgressBar = %ProgressBar
@onready var purchase_button: Button = $MarginContainer/VBoxContainer/PurchaseButton

var upgrade : MetaUpgrade


func _ready() -> void:
	purchase_button.pressed.connect(_on_purchase_pressed)


func set_meta_upgrade(card_upgrade: MetaUpgrade) -> void:
	upgrade = card_upgrade
	name_label.text = upgrade.name
	description_label.text = upgrade.description
	update_progress()


func update_progress() -> void:
	var coins : float = MetaProgression.data["coins"]
	var percent : float = coins / upgrade.cost
	percent = min(percent, 1)
	progress_bar.value = percent
	purchase_button.disabled = percent < 1
	progress_label.text = str(coins) + "/" + str(upgrade.cost)


func _on_purchase_pressed() -> void:
	if upgrade == null:
		return
	MetaProgression.add_meta_upgrade(upgrade)
	MetaProgression.data["coins"] -= upgrade.cost
	MetaProgression.save_data()
	get_tree().call_group("meta_upgrade_cards", "update_progress")
	animation_player.play("select")
