extends Node2D


func _ready():
	pass


func _on_CombatStartButton_pressed() -> void:
	get_tree().change_scene('res://combat/Combat.tscn')
