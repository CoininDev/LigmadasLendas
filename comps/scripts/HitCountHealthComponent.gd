extends HealthComponent

func damage(atk: Attack):
	health -= 1
	damaged.emit()
	handle_death(atk)

func damage_continuous(atk: Attack):
	pass

func heal(healing:float):
	if health < MAX_HEALTH:
		health += 1
