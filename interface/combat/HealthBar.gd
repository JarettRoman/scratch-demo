extends Control

onready var health_bar: TextureProgress = $HealthBar


func _on_Combatant_health_updated(health: int) -> void:
	health_bar.value = health


func _on_Combatant_max_health_updated(max_health: int) -> void:
	health_bar.max_value = max_health
