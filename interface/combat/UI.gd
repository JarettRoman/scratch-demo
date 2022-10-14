extends Control

onready var buttons: Array = $Buttons/GridContainer.get_children()
onready var attack_button := $Buttons/GridContainer/Attack
var combatants_node: Node2D  # get rid of this. just around for quick testing


func initialize(_combatants_node: Node2D) -> void:
	combatants_node = _combatants_node
	attack_button.grab_focus()


func _on_Attack_button_up():
	if not combatants_node.get_node("Hero").is_active:
		return
	combatants_node.get_node("Hero").attack(combatants_node.get_node("Ghost"))
