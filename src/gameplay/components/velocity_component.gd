extends Node
class_name VelocityComponent

@export var max_speed : int = 40
@export var acceleration : float = 5

var velocity : Vector2 = Vector2.ZERO


func accelerate_to_player():
	var owner_node_2d : Node2D = owner as Node2D
	if owner_node_2d == null:
		return

	var player : Player = get_tree().get_first_node_in_group("player") as Player
	if player == null:
		return
	
	var direction : Vector2 = (player.global_position - owner_node_2d.global_position).normalized()
	accelerate_in_direction(direction)


func accelerate_in_direction(direction : Vector2):
	var desired_velocity : Vector2 = direction * max_speed
	var weight : float = 1.0 - exp(-acceleration * get_process_delta_time())
	velocity = velocity.lerp(desired_velocity, weight)


func move(character_body : CharacterBody2D):
	character_body.velocity = velocity
	character_body.move_and_slide()
	velocity = character_body.velocity
