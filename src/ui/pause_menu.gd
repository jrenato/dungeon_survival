extends CanvasLayer

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var panel_container: PanelContainer = $MarginContainer/PanelContainer
@onready var resume_button: Button = %ResumeButton
@onready var options_button: Button = %OptionsButton
@onready var quit_button: Button = %QuitButton


func _ready() -> void:
	resume_button.pressed.connect(_on_resume_button_pressed)
	animation_player.play("default")

	var tween = create_tween()
	tween.tween_property(panel_container, "scale", Vector2.ZERO, 0.0)
	tween.tween_property(panel_container, "scale", Vector2.ONE, 0.3)\
		.set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_BACK)


func _on_resume_button_pressed() -> void:
	pass
