extends State
class_name  EnemyFollow

@export var enemy: CharacterBody2D
@export var move_speed := 70.0
var player: CharacterBody2D
var attack = false

func enter():
	player = get_tree().get_first_node_in_group("player")



func physics_update(delta: float):
	if player:
		enemy.navigation_agent_2d.target_position = player.global_position
		var direction = enemy.navigation_agent_2d.get_next_path_position() - enemy.global_position
		
		# Check the length of the direction vector before normalizing
		if direction.length() > 150:
			Transitioned.emit(self, "Idle")
		else:
			if not enemy.navigation_agent_2d.is_navigation_finished():
				enemy.velocity = direction.normalized() * move_speed

		if enemy.player_detection_zone.can_see_player():
			Transitioned.emit(self, "Attack")
