extends Node


var current_experience : int = 0


func _ready() -> void:
	GameEvents.experience_vial_collected.connect(on_experience_vial_collected)


func increment_experience(ammount: int) -> void:
	current_experience += ammount


func on_experience_vial_collected(ammount: int) -> void:
	increment_experience(ammount)
