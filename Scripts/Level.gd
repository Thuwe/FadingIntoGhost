extends Node2D

signal level_finished(next_level)

export var next_level:String = ""

onready var objects:Node2D = get_node("%Objects")
onready var soul_character:Node2D = get_node("%SoulCharacter")
onready var spawn:Sprite = get_node("%Spawn")
onready var text_ui:Control = get_node("%TextUi")

var game_parent:Node2D

func _ready() -> void:
	text_ui.visible = true
	GameData.is_in_light = false
#	if objects != null:
#		for one_node in objects.get_children():
#			if one_node.is_in_group("Switch"):
#				one_node.activate_switch()
#				one_node.connect("exited_light", soul_character, "on_light_exited")
	var _con_err = soul_character.connect("faded", self, "reload_level")
	GameData.fading_level = GameData.default_fading
	soul_character.position = spawn.position
	soul_character.set_physics_process(false)

func _on_Exit_body_entered(_body) -> void:
	soul_character.queue_free()
	emit_signal("level_finished", next_level)
	
func reload_level() -> void:
	soul_character.set_physics_process(false)
	yield(game_parent.faded_screen(), "completed")
	GameData.fading_level = GameData.default_fading
	soul_character.position = spawn.position
#	GameData.is_in_light = false
	soul_character.change_visibility(GameData.default_fading)
	soul_character.set_physics_process(true)
	if objects != null:
		for one_node in objects.get_children():
			if one_node.is_in_group("Switch"):
				one_node.activate_switch()
	
func _input(event):
	if event.is_action_pressed("close_text"):
		text_ui.visible = false
		soul_character.set_physics_process(true)


func _on_Switch_desactivated(torch_name):
	if objects != null:
		for one_node in objects.get_children():
			if one_node.name == torch_name:
				one_node.desactivate_light()


func _on_Switch_activated(torch_name):
	if objects != null:
		for one_node in objects.get_children():
			if one_node.name == torch_name:
				one_node.activate_light()

