extends State
class_name Attack

var launch = false

func enter():
	owner.animation_player.play("attack")
func physics_update(delta):
		if not owner.player_detection_zone.can_see_player():
			Transitioned.emit(self,"Follow")
