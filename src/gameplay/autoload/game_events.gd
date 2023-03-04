extends Node


signal experience_vial_collected(ammount: int)
signal ability_upgraded(upgrade: AbilityUpgrade, current_upgrades: Dictionary)


func emit_experience_vial_collected(ammount: int) -> void:
	experience_vial_collected.emit(ammount)


func emit_ability_upgraded(upgrade: AbilityUpgrade, current_upgrades: Dictionary) -> void:
	ability_upgraded.emit(upgrade, current_upgrades)
