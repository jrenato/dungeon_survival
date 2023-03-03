extends Node2D


@onready var area_2d: Area2D = %Area2D


func _ready() -> void:
	area_2d.area_entered.connect(on_area_entered)


func on_area_entered(other_area: Area2D) -> void:
	GameEvents.emit_experience_vial_collected(1.0)
	queue_free()
