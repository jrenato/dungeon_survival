extends Node

@export var end_screen_scene : PackedScene

@onready var player: Player = %Player

var pause_menu_scene : PackedScene = preload("res://src/ui/pause_menu.tscn")


func _ready() -> void:
	RenderingServer.set_default_clear_color(Color("763b36"))
	player.health_component.died.connect(_on_player_died)


func _unhandled_input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("pause"):
		add_child(pause_menu_scene.instantiate())
		get_tree().root.set_input_as_handled()


func _on_player_died() -> void:
	var end_screen: EndScreen = end_screen_scene.instantiate()
	add_child(end_screen)
	end_screen.set_defeat()
	player.queue_free()
	MetaProgression.save_data()
