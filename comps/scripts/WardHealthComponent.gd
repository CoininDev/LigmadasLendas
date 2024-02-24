extends HealthComponent


func damage(atk: Attack):
	health -= 1
	damaged.emit()
	
	handle_death(atk)

func heal(_heal: float):
	if health < MAX_HEALTH:
		health += 1


#usado para dano contínuo, aqui será ignorado
func ignore_resistance_damage(_atk:Attack):
	pass