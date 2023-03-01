extends CanvasLayer


@onready var time_label: Label = %TimeLabel

@export var arena_manager : ArenaManager


func _process(delta: float) -> void:
	if arena_manager == null:
		return

	var time_elapsed : float = arena_manager.get_time_elapsed()
	time_label.text = format_time(time_elapsed)


func format_time(seconds : float) -> String:
	var minutes : int = floor(seconds / 60)
	var remaining_seconds : float = seconds - (minutes * 60)
	return "%02d:%02d" % [minutes, remaining_seconds]
