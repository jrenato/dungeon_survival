extends CanvasLayer


@export var experiente_manager : ExperienceManager


@onready var progress_bar: ProgressBar = %ProgressBar


func _ready() -> void:
	progress_bar.value = 0.0
	experiente_manager.experience_updated.connect(on_experience_update)


func on_experience_update(current_experience : float, target_experience : float) -> void:
	progress_bar.value = current_experience / target_experience
