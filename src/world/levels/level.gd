extends Node


@export var end_screen_scene : PackedScene


@onready var player: Player = %Player


func _ready() -> void:
	RenderingServer.set_default_clear_color(Color("763b36"))
	player.health_component.died.connect(_on_player_died)


func _on_player_died() -> void:
	var end_screen: EndScreen = end_screen_scene.instantiate()
	add_child(end_screen)
	end_screen.set_defeat_message()
	player.queue_free()
