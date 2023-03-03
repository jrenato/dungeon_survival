extends Node


signal experience_vial_collected(ammount: float)


func emit_experience_vial_collected(ammount: float) -> void:
	experience_vial_collected.emit(ammount)
