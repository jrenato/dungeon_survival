extends Node2D


@export var health_component : HealthComponent
@export var sprite : Sprite2D

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var gpu_particles_2d: GPUParticles2D = $GPUParticles2D
@onready var hit_random_player: RandomStreamPlayer2dComponent = $HitRandomPlayerComponent as RandomStreamPlayer2dComponent


func _ready() -> void:
	set_particles_texture()
	health_component.died.connect(_on_died)


func set_particles_texture():
	var atlas_texture : AtlasTexture = AtlasTexture.new()
	atlas_texture.atlas = sprite.texture
	if sprite.region_enabled:
		atlas_texture.region = sprite.region_rect
	gpu_particles_2d.texture = atlas_texture


func _on_died() -> void:
	if owner == null || not owner is Node2D:
		return

	var spawn_position : Vector2 = owner.global_position

	var entities_layer : Node = get_tree().get_first_node_in_group("entities_layer")
	get_parent().remove_child(self)
	entities_layer.add_child(self)

	global_position = spawn_position
	animation_player.play("default")

	hit_random_player.play_random()
