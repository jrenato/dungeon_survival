extends Node


@export_range(0, 1) var drop_percent : float = 0.5
@export var vial_scene : PackedScene
@export var health_component : HealthComponent


func _ready() -> void:
	health_component.died.connect(on_died)


func on_died() -> void:
	var adjusted_drop_percent : float = drop_percent
	var experience_gain_level : int = MetaProgression.get_meta_upgrade_level("experience_gain")
	if experience_gain_level > 0:
		adjusted_drop_percent += .1 * experience_gain_level

	if randf() > adjusted_drop_percent:
		return

	if vial_scene == null:
		return
	
	if not owner is Node2D:
		return

	var vial_instance = vial_scene.instantiate() as Node2D
	var entities_layer = get_tree().get_first_node_in_group("entities_layer")
	entities_layer.add_child(vial_instance)
	vial_instance.global_position = (owner as Node2D).global_position
