extends CharacterBody2D

@export var stats : Stats

@onready var sprite = $Sprite2D
@onready var animation_player = $AnimationPlayer
@onready var player_detection_zone = $PlayerDetectedZone
@onready var hit_animaiton  = $HitAnimation
@onready var collision = $CollisionShape2D
@onready var timer = $Timer
@onready var state_machine = $StateMachine
@onready var health_bar = $HealthBar
@onready var hurt_box =$HurtBox
@onready var walk_animation = $WalkAnimation
@onready var hurt = $Hurt
@onready var death_audio = $DeathAudio
@onready var navigation_agent_2d = $NavigationAgent2D


var is_dead = false
signal health_depleted

func _ready():
	health_bar.init_health(stats.max_health)	
	stats.health = stats.max_health


func _physics_process(delta):
	move_and_slide()
	
	if velocity.length() > 0:
		walk_animation.play("walk")
	if velocity.x > 0:
		$Sprite2D.flip_h = true
	else:
		$Sprite2D.flip_h = false


func _on_hurt_box_area_entered(area):
	if not area.is_in_group("enemies") and not is_dead:
		hit_animaiton.play("RESET")
		hurt.play()
		if stats.health > 0 :
			health_bar.health = stats.health
		else:
			health_bar.visible = false
			state_machine.on_child_transition(state_machine.current_state, "Death")
			emit_signal("health_depleted")
func _on_timer_timeout():
	queue_free()
