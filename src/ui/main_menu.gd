extends CanvasLayer
class_name MainMenu

@onready var play_button: Button = %PlayButton
@onready var options_button: Button = %OptionsButton
@onready var quit_button: Button = %QuitButton

var options_menu_scene : PackedScene = preload("res://src/ui/options_menu.tscn")


func _ready() -> void:
	play_button.pressed.connect(_on_play_button_pressed)
	options_button.pressed.connect(_on_options_button_pressed)
	quit_button.pressed.connect(_on_quit_button_pressed)


func _on_play_button_pressed() -> void:
	get_tree().change_scene_to_file("res://src/world/levels/level.tscn")


func _on_options_button_pressed() -> void:
	var options_menu : OptionsMenu = options_menu_scene.instantiate() as OptionsMenu
	add_child(options_menu)
	options_menu.back_button.pressed.connect(_on_options_close.bind(options_menu))


func _on_quit_button_pressed() -> void:
	get_tree().quit()


func _on_options_close(options_menu : OptionsMenu) -> void:
	options_menu.queue_free()
