extends Node
class_name HealthComponent


signal died
signal health_changed
signal health_decreased


@export var max_health : float = 10.0


var current_health : float


func _ready() -> void:
	current_health = max_health


func damage(ammount: float) -> void:
	current_health = clamp(current_health - ammount, 0, max_health)
	health_changed.emit()

	if ammount > 0:
		health_decreased.emit()

	Callable(check_death).call_deferred()


func heal(ammount: float) -> void:
	damage(-ammount)


func get_health_percent() -> float:
	if max_health <= 0:
		return 0
	return min(current_health / max_health, 1)


func check_death() -> void:
	if current_health == 0:
		died.emit()
		owner.queue_free()
