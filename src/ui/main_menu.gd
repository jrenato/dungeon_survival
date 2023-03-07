extends CanvasLayer

@onready var play_button: Button = %PlayButton
@onready var options_button: Button = %OptionsButton
@onready var quit_button: Button = %QuitButton


func _ready() -> void:
	play_button.pressed.connect(_on_play_button_pressed)
	options_button.pressed.connect(_on_options_button_pressed)
	quit_button.pressed.connect(_on_quit_button_pressed)


func _on_play_button_pressed() -> void:
	get_tree().change_scene_to_file("res://src/world/levels/level.tscn")


func _on_options_button_pressed() -> void:
	pass


func _on_quit_button_pressed() -> void:
	get_tree().quit()
