extends Node

#const SAVE_FILE_PATH = "user://game.save"
const SAVE_FILE_PATH = "user://game.json"

var data : Dictionary = {
	"coins": 0,
	"meta_upgrades": {}
}


func _ready() -> void:
	GameEvents.experience_vial_collected.connect(_on_experience_collected)
	load_data()


func load_data() -> void:
	if not FileAccess.file_exists(SAVE_FILE_PATH):
		return
	var file : FileAccess = FileAccess.open(SAVE_FILE_PATH, FileAccess.READ)
	# TODO: Research if get_var and store_var are safe
#	data = file.get_var()
	var json = JSON.new()
	var parse_result = json.parse(file.get_as_text())
	if parse_result != OK:
		printerr("Error loading options")
		return

	data = json.get_data()


func save_data():
	var file : FileAccess = FileAccess.open(SAVE_FILE_PATH, FileAccess.WRITE)
#	file.store_var(data)
	var json_string : String = JSON.stringify(data, "\t")
	file.store_string(json_string)


func add_meta_upgrade(upgrade: MetaUpgrade) -> void:
	if not data["meta_upgrades"].has(upgrade.id):
		data["meta_upgrades"][upgrade.id] = {
			"level": 0
		}
	data["meta_upgrades"][upgrade.id]["level"] += 1


func _on_experience_collected(ammount: float) -> void:
	data["coins"] += ammount
