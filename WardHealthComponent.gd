extends HealthComponent


func damage(atk: Attack):
	
	health -= 1
	damaged.emit()
	
	handle_death(atk)

func heal(atk: float):
	health += 1

func ignore_resistance_damage(atk:Attack):
	pass
