extends Node
class_name ExperienceManager


signal experience_updated(current_experience : float, target_experience : float)
signal level_up(new_level : int)


const TARGET_EXPERIENCE_GROWTH : int = 5


var current_experience : int = 0
var target_experience : int = 1
var current_level : int = 1


func _ready() -> void:
	GameEvents.experience_vial_collected.connect(on_experience_vial_collected)


func increment_experience(ammount: int) -> void:
	current_experience = min(current_experience + ammount, target_experience)

	if current_experience == target_experience:
		current_level += 1
		target_experience += TARGET_EXPERIENCE_GROWTH
		current_experience = 0
		level_up.emit(current_level)

	experience_updated.emit(current_experience, target_experience)


func on_experience_vial_collected(ammount: int) -> void:
	increment_experience(ammount)
