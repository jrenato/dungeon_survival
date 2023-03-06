extends PanelContainer
class_name AbilityUpgradeCard

signal selected(ability_upgrade: AbilityUpgrade)

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var hover_animation_player: AnimationPlayer = $HoverAnimationPlayer
@onready var name_label: Label = %NameLabel
@onready var description_label: Label = %DescriptionLabel

var disabled : bool = false


func _ready() -> void:
	gui_input.connect(_on_gui_input)
	mouse_entered.connect(_on_mouse_entered)


func play_enter(delay : float = 0) -> void:
	modulate = Color.TRANSPARENT
	await get_tree().create_timer(delay).timeout
	animation_player.play("enter")


func play_discard(delay : float = 0) -> void:
	await get_tree().create_timer(delay).timeout
	animation_player.play("discard")


func set_ability_upgrade(upgrade: AbilityUpgrade) -> void:
	name_label.text = upgrade.name
	description_label.text = upgrade.description


func select_card() -> void:
	disabled = true
	animation_player.play("select")

	for other_card in get_tree().get_nodes_in_group("upgrade_cards"):
		if other_card != self:
			other_card.play_discard()

	await animation_player.animation_finished
	selected.emit()


func _on_gui_input(event: InputEvent) -> void:
	if disabled:
		return

	if event.is_action_pressed("left_click"):
		select_card()


func _on_mouse_entered() -> void:
	if disabled:
		return
	hover_animation_player.play("hover")
