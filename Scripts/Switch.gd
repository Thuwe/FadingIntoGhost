extends StaticBody2D

signal switch_activated(torch_name)
signal switch_desactivated(torch_name)

onready var switch_sprite = get_node("%SwitchSprite")

export var is_on = true
export var torch_node_name:String = ""

func change_state() -> void:
	if is_on:
		desactivate_switch()
	else:
		activate_switch()

func desactivate_switch() -> void:
	switch_sprite.frame = 1
	is_on = false
	emit_signal("switch_desactivated", torch_node_name)
	
func activate_switch() -> void:
	switch_sprite.frame = 0
	is_on = true
	emit_signal("switch_activated", torch_node_name)
