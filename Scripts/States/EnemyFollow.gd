extends State
class_name  EnemyFollow

@export var enemy: CharacterBody2D
@export var move_speed := 100.0
var player: CharacterBody2D
var attack = false

func enter():
	player = get_tree().get_first_node_in_group("player")

func physics_update(delta:float):
	var direction = player.global_position - enemy.global_position
	enemy.velocity = direction.normalized() * move_speed	
	if enemy.velocity.length() > 0:
		enemy.animation_player.play("walk")
		
	if  enemy.velocity.x > 0:
		enemy.sprite.flip_h = true
	else :
		enemy.sprite.flip_h = false
	if enemy.player_detection_zone.can_see_player():
		Transitioned.emit(self, "Attack")
