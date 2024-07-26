extends Area2D
class_name PlayerDetectedZone

var player = null

func can_see_player():
	return player != null
	print("work")
func _on_body_entered(body):
	player = body

func _on_body_exited(body):
	player = null
