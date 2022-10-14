extends Node2D

onready var turn_queue: TurnQueue = $TurnQueue
onready var enemy: Node2D = $Combatants/Ghost
onready var player: Node2D = $Combatants/Hero
onready var combatants_node := $Combatants
onready var UI := $UI

signal combat_finished


func _ready() -> void:
	# var combatants: Array = combatants.get_children()
	# for combatant in combatants: /..
	# combatant.connect("turn_finished", turn_queue, )
	# TurnQueue.connect("turn_finished", combatant, )
	var combatants: Array = combatants_node.get_children()

	for combatant in combatants:
		var err = combatant.connect("health_depleted", self, "_on_combatant_death", [combatant])
		if err != OK:
			print("Error!")
	turn_queue.initialize(combatants)
	$UI.initialize(combatants_node)


func finish_combat() -> void:
	emit_signal("combat_finished")


# removes dead combatant from combat. if there are no more enemies, combat ends
func _on_combatant_death(combatant: Combatant) -> void:
	# remove from turn queue
	var animation_player = combatant.get_node("AnimationPlayer")
	animation_player.play("die")
	yield(animation_player, "animation_finished")
	$TurnQueue.remove(combatant)
	var queue: Array = $TurnQueue.get_queue()
	for _combatant in queue:
		if not _combatant.is_ally:
			# if at least one enemy remains, we do not end combat
			return
	finish_combat()
