extends Control



func _input(event) -> void:
	if event.is_action_pressed("pause"):
		get_tree().paused = !get_tree().paused
		self.visible = !self.visible
		
	if get_tree().paused:
		if event.is_action_pressed("quit"):
			get_tree().paused = false
			self.visible = false
			var _chg_err = get_tree().change_scene("res://Scenes/GameMenu.tscn")
