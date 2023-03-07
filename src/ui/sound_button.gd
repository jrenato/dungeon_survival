extends Button

@onready var random_player: RandomStreamPlayerComponent = $RandomStreamPlayerComponent as RandomStreamPlayerComponent


func _ready() -> void:
	pressed.connect(_on_pressed)


func _on_pressed() -> void:
	random_player.play_random()
