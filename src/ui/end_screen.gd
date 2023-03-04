extends CanvasLayer
class_name EndScreen


@onready var title_label: Label = %TitleLabel
@onready var message_label: Label = %MessageLabel
@onready var restart_button: Button = %RestartButton
@onready var quit_button: Button = %QuitButton


func _ready() -> void:
	get_tree().paused = true
	restart_button.pressed.connect(_on_restart_button_pressed)
	quit_button.pressed.connect(_on_quit_button_pressed)


func set_defeat_message() -> void:
	title_label.text = "Defeat"
	message_label.text = "You lost"


func _on_restart_button_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://src/world/levels/level.tscn")


func _on_quit_button_pressed() -> void:
	get_tree().quit()
