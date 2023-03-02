extends Node
class_name HealthComponent

signal died

@export var max_health : float = 10.0
var current_health : float


func _ready() -> void:
	current_health = max_health


func damage(ammount: float) -> void:
	current_health = max(current_health - ammount, 0)
	died.emit()
	owner.queue_free()
