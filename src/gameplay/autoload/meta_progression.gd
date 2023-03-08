extends Node

const SAVE_FILE_PATH = "user://game.save"

var data : Dictionary = {
	"coins": 0,
	"meta_upgrades": {}
}


func _ready() -> void:
	GameEvents.experience_vial_collected.connect(_on_experience_collected)
	load_data()


func load_data():
	if not FileAccess.file_exists(SAVE_FILE_PATH):
		return
	var file : FileAccess = FileAccess.open(SAVE_FILE_PATH, FileAccess.READ)
	data = file.get_var()


func save_data():
	var file : FileAccess = FileAccess.open(SAVE_FILE_PATH, FileAccess.WRITE)
	file.store_var(data)


func add_meta_upgrade(upgrade: MetaUpgrade) -> void:
	if not data["meta_upgrades"].has(upgrade.id):
		data["meta_upgrades"][upgrade.id] = {
			"level": 0
		}
	data["meta_upgrades"][upgrade.id]["level"] += 1


func _on_experience_collected(ammount: float) -> void:
	data["coins"] += ammount
