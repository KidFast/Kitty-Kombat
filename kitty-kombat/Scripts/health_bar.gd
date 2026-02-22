extends ProgressBar

@onready var timer = $Timer
@onready var damage_bar = $damage_bar

var health = 100

func _set_health(new_health):
	var previous_health = health
	health = min(max_value, new_health)
	value = health
	
	if health <= 0:
		queue_free()
		
	if health < previous_health:
		timer.start()


func _on_timer_timeout():
	damage_bar.value = health
