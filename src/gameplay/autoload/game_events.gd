extends Node


signal experience_vial_collected(ammount: int)


func emit_experience_vial_collected(ammount: int) -> void:
	experience_vial_collected.emit(ammount)
