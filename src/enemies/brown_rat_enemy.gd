extends CharacterBody2D
class_name BrownRatEnemy

@onready var velocity_component: VelocityComponent = $VelocityComponent as VelocityComponent
@onready var hurtbox_component: HurtboxComponent = $HurtboxComponent as HurtboxComponent
@onready var visuals: Node2D = $Visuals
@onready var audio_stream_player: RandomAudioStreamPlayer = $HitRandomAudioPlayerComponent as RandomAudioStreamPlayer


func _ready() -> void:
	hurtbox_component.hit.connect(_on_hit)


func _process(delta: float) -> void:
	velocity_component.accelerate_to_player()
	velocity_component.move(self)
	
	var move_sign : int = sign(velocity.x)
	if move_sign != 0:
		visuals.scale = Vector2(-move_sign, 1)


func _on_hit() -> void:
	audio_stream_player.play_random()
