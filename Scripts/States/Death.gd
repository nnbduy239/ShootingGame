extends State
class_name Death


func enter():
	owner.animation_player.play("death")
	owner.timer.start()
	
