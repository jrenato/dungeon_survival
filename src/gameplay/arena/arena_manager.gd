extends Node
class_name ArenaManager

signal arena_difficulty_changed(arena_difficulty : int)

const DIFFICULTY_INTERVAL : int = 5

@export var end_screen_scene : PackedScene

@onready var timer: Timer = %Timer

var arena_difficulty : int = 1


func _ready() -> void:
	timer.timeout.connect(on_timer_timeout)


func _process(delta: float) -> void:
	var next_time_target = timer.wait_time - (arena_difficulty * DIFFICULTY_INTERVAL)
	if timer.time_left <= next_time_target:
		arena_difficulty += 1
		arena_difficulty_changed.emit(arena_difficulty)


func get_time_elapsed() -> float:
	return timer.wait_time - timer.time_left


func on_timer_timeout() -> void:
	var end_screen = end_screen_scene.instantiate()
	add_child(end_screen)
