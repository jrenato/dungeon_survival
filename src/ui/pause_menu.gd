extends CanvasLayer

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var panel_container: PanelContainer = $MarginContainer/PanelContainer
@onready var resume_button: Button = %ResumeButton
@onready var options_button: Button = %OptionsButton
@onready var quit_button: Button = %QuitButton

var options_menu_scene : PackedScene = preload("res://src/ui/options_menu.tscn")

var is_closing : bool = false


func _ready() -> void:
	resume_button.pressed.connect(_on_resume_button_pressed)
	options_button.pressed.connect(_on_options_button_pressed)
	quit_button.pressed.connect(_on_quit_button_pressed)

	get_tree().paused = true
	panel_container.pivot_offset = panel_container.size / 2 
	animation_player.play("default")

	var tween = create_tween()
	tween.tween_property(panel_container, "scale", Vector2.ZERO, 0.0)
	tween.tween_property(panel_container, "scale", Vector2.ONE, 0.3)\
		.set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_BACK)


func _unhandled_input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("pause"):
		get_tree().root.set_input_as_handled
		close()


func close() -> void:
	if is_closing:
		return

	is_closing = true
	animation_player.play_backwards("default")

	var tween = create_tween()
	tween.tween_property(panel_container, "scale", Vector2.ONE, 0.0)
	tween.tween_property(panel_container, "scale", Vector2.ZERO, 0.3)\
		.set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_BACK)

	await tween.finished

	get_tree().paused = false
	queue_free()


func _on_resume_button_pressed() -> void:
	close()


func _on_options_button_pressed() -> void:
#	ScreenTransition.transition()
#	await ScreenTransition.transition_halfway
	var options_menu : OptionsMenu = options_menu_scene.instantiate() as OptionsMenu
	add_child(options_menu)
	options_menu.back_button.pressed.connect(_on_options_close.bind(options_menu))


func _on_options_close(options_menu : OptionsMenu) -> void:
	options_menu.queue_free()


func _on_quit_button_pressed() -> void:
	ScreenTransition.transition()
	await ScreenTransition.transition_halfway
	get_tree().paused = false
	get_tree().change_scene_to_file("res://src/ui/main_menu.tscn")
