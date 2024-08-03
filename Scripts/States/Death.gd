extends State
class_name Death


func enter():
	if not owner.is_dead:
		owner.is_dead = true
		owner.animation_player.play("death")
		owner.death_audio.play()
		owner.collision.set_deferred("disabled", true)
		owner.hurt_box.set_deferred("disabled", true)
		owner.timer.start()
	
