extends  Control

var _is_paused: bool = false:
	set = set_paused


func _unhandled_input(event):
	if event.is_action_pressed("pause") and not Global.stage_cleard:
		_is_paused = !_is_paused
		

func set_paused(value):
	_is_paused = value
	get_tree().paused = _is_paused
	visible = _is_paused


func _on_resume_pressed():
	_is_paused = false

func _on_restart_pressed():
	_is_paused = false	
	get_tree().reload_current_scene()
	
func _on_quit_pressed():
	_is_paused = false
	get_tree().change_scene_to_file("res://Scenes/UI/menu.tscn")
