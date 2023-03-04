extends Node
class_name ArenaManager


@export var victory_screen_scene : PackedScene


@onready var timer: Timer = %Timer


func _ready() -> void:
	timer.timeout.connect(on_timer_timeout)


func get_time_elapsed() -> float:
	return timer.wait_time - timer.time_left


func on_timer_timeout() -> void:
	var victory_screen = victory_screen_scene.instantiate()
	add_child(victory_screen)
