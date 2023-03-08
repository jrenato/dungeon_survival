extends Node

var save_data : Dictionary = {
	"coins": 0,
	"meta_upgrades": {}
}


func _ready() -> void:
	GameEvents.experience_vial_collected.connect(_on_experience_collected)


func add_meta_upgrade(upgrade: MetaUpgrade) -> void:
	if not save_data["meta_upgrades"].has(upgrade.id):
		save_data["meta_upgrades"][upgrade.id] = {
			"level": 0
		}
	save_data["meta_upgrades"][upgrade.id]["level"] += 1


func _on_experience_collected(ammount: float) -> void:
	save_data["coins"] += ammount
