extends State
class_name EnemyIdle

@export var enemy: CharacterBody2D
@export var move_speed := 100
var player: CharacterBody2D

var move_direction
var warder_time

func randomize_wander():
	move_direction = Vector2(randf_range(-1, 1), randf_range(-1, 1)).normalized()
	warder_time = randf_range(1, 3)

func enter():
	randomize_wander()
	player = get_tree().get_first_node_in_group("player")
func update(delta):
	if warder_time > 0:
		warder_time -= delta
	
	else :
		randomize_wander()
func physics_update(delta):
	if enemy:
		enemy.velocity = move_direction * move_speed
	var direction = player.global_position - enemy.global_position
	if direction.length() < 250:
		Transitioned.emit(self,"Follow")
