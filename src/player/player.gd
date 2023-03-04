extends CharacterBody2D
class_name Player


const MAX_SPEED : int = 125
const ACCELERATION_SMOOTHING : int = 25


@onready var health_component: HealthComponent = $HealthComponent
@onready var collision_area_2d: Area2D = %CollisionArea2D
@onready var damage_interval_timer: Timer = $DamageIntervalTimer


var number_of_colliding_bodies : int = 0


func _ready() -> void:
	collision_area_2d.body_entered.connect(_on_body_entered)
	collision_area_2d.body_exited.connect(_on_body_exited)
	damage_interval_timer.timeout.connect(_on_damage_interval_timer_timeout)


func _process(delta: float) -> void:
	var direction : Vector2 = get_movement_vector()
	var target_velocity : Vector2 = direction * MAX_SPEED

	#velocity = velocity.move_toward(target_velocity, delta)
	velocity = velocity.lerp(target_velocity, 1 - exp(-delta * ACCELERATION_SMOOTHING))

	move_and_slide()


func get_movement_vector() -> Vector2:
	return Input.get_vector("move_left", 'move_right', "move_up", "move_down")


func check_for_damage() -> void:
	if number_of_colliding_bodies == 0 || !damage_interval_timer.is_stopped():
		return
	health_component.damage(1)
	damage_interval_timer.start()


func _on_body_entered(other_body: Node2D) -> void:
	number_of_colliding_bodies += 1
	check_for_damage()


func _on_body_exited(other_body: Node2D) -> void:
	number_of_colliding_bodies -= 1


func _on_damage_interval_timer_timeout() -> void:
	check_for_damage()
