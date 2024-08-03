extends Node2D

@onready var boss = $Boss
@onready var timer = $Timer
@onready var stage_clear = $CanvasLayer2/StageClear


func _ready():
	Bgm.play()
	#boss.connect("health_depleted","on_boss_health_depleted")

func _on_boss_health_depleted():
	timer.start()
	
func _on_timer_timeout():
	Global.stage_cleard = true
	stage_clear.set_paused(true)
