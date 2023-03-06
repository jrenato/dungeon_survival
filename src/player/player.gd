extends CharacterBody2D
class_name Player

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var velocity_component: VelocityComponent = $VelocityComponent as VelocityComponent
@onready var health_component: HealthComponent = $HealthComponent as HealthComponent
@onready var abilities: Node = $Abilities
@onready var health_bar: ProgressBar = %HealthBar
@onready var visuals: Node2D = $Visuals
@onready var damage_area_2d: Area2D = %DamageArea2D
@onready var damage_interval_timer: Timer = $DamageIntervalTimer


var number_of_colliding_bodies : int = 0


func _ready() -> void:
	damage_area_2d.body_entered.connect(_on_body_entered)
	damage_area_2d.body_exited.connect(_on_body_exited)
	damage_interval_timer.timeout.connect(_on_damage_interval_timer_timeout)
	health_component.health_changed.connect(_on_health_changed)

	GameEvents.ability_upgraded.connect(_on_ability_upgraded)

	update_health_bar()


func _process(delta: float) -> void:
	var direction : Vector2 = get_movement_vector()
	velocity_component.accelerate_in_direction(direction)
	velocity_component.move(self)

	if direction != Vector2.ZERO:
		animation_player.play("walk")
	else:
		animation_player.stop()

	var move_sign : int = sign(direction.x)
	if move_sign != 0:
		visuals.scale = Vector2(move_sign, 1)


func get_movement_vector() -> Vector2:
	return Input.get_vector("move_left", 'move_right', "move_up", "move_down")


func check_for_damage() -> void:
	if number_of_colliding_bodies == 0 || !damage_interval_timer.is_stopped():
		return
	health_component.damage(1)
	damage_interval_timer.start()


func update_health_bar() -> void:
	health_bar.value = health_component.get_health_percent()


func _on_body_entered(other_body: Node2D) -> void:
	number_of_colliding_bodies += 1
	check_for_damage()


func _on_body_exited(other_body: Node2D) -> void:
	number_of_colliding_bodies -= 1


func _on_damage_interval_timer_timeout() -> void:
	check_for_damage()


func _on_health_changed() -> void:
	update_health_bar()


func _on_ability_upgraded(upgrade : AbilityUpgrade, current_upgrades : Dictionary) -> void:
	if not upgrade is Ability:
		return

	var ability : Ability = upgrade as Ability
	abilities.add_child(ability.ability_controller_scene.instantiate())
