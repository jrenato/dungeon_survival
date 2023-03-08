extends CanvasLayer
class_name EndScreen

@onready var victory_player: AudioStreamPlayer = %VictoryStreamPlayer
@onready var defeat_player: AudioStreamPlayer = %DefeatStreamPlayer
@onready var panel_container: PanelContainer = %PanelContainer
@onready var title_label: Label = %TitleLabel
@onready var message_label: Label = %MessageLabel
@onready var restart_button: Button = %RestartButton
@onready var quit_button: Button = %QuitButton


func _ready() -> void:
	panel_container.pivot_offset = panel_container.size / 2
	var tween : Tween = create_tween()
	tween.tween_property(panel_container, "scale", Vector2.ZERO, 0.0)
	tween.tween_property(panel_container, "scale", Vector2.ONE, 0.3)\
		.set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_BACK)


	get_tree().paused = true
	restart_button.pressed.connect(_on_restart_button_pressed)
	quit_button.pressed.connect(_on_quit_button_pressed)


func set_defeat() -> void:
	title_label.text = "Defeat"
	message_label.text = "You lost"
	play_jingle(true)


func play_jingle(defeat: bool = false) -> void:
	if defeat:
		defeat_player.play()
	else:
		victory_player.play()


func _on_restart_button_pressed() -> void:
	ScreenTransition.transition()
	await ScreenTransition.transition_halfway
	get_tree().paused = false
	get_tree().change_scene_to_file("res://src/world/levels/level.tscn")


func _on_quit_button_pressed() -> void:
	get_tree().quit()
