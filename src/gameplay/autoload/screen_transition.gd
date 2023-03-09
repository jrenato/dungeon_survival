extends CanvasLayer

signal transition_halfway

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var color_rect: ColorRect = $ColorRect

var skip_emit : bool = false


func transition() -> void:
#	color_rect.visible = true
	animation_player.play("default")
	await transition_halfway
	skip_emit = true
	animation_player.play_backwards("default")
#	await animation_player.animation_finished
#	color_rect.visible = false


func transition_to_scene(scene_path : String) -> void:
	transition()
	await transition_halfway
	get_tree().change_scene_to_file(scene_path)


func emit_transition_halfway() -> void:
	if skip_emit:
		skip_emit = false
		return

	transition_halfway.emit()
