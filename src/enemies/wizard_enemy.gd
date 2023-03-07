extends CharacterBody2D
class_name WizardEnemy


@onready var velocity_component: VelocityComponent = $VelocityComponent as VelocityComponent
@onready var visuals: Node2D = $Visuals
@onready var hurtbox_component: Area2D = $HurtboxComponent
@onready var random_player: RandomStreamPlayerComponent = $HitRandomPlayerComponent as RandomStreamPlayerComponent

var is_moving : bool = false


func _ready() -> void:
	hurtbox_component.hit.connect(_on_hit)


func _process(delta: float) -> void:
	if is_moving:
		velocity_component.accelerate_to_player()
	else:
		velocity_component.decelerate()

	velocity_component.move(self)
	
	var move_sign : int = sign(velocity.x)
	if move_sign != 0:
		visuals.scale = Vector2(move_sign, 1)


func set_is_moving(moving : bool):
	is_moving = moving


func _on_hit() -> void:
	random_player.play_random()
