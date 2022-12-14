extends Area2D



func _on_LightArea_body_entered(body):
	if body.is_in_group("character"):
		GameData.is_in_light = !GameData.is_in_light
		


func _on_LightArea_body_exited(body):
	if body.is_in_group("character"):
		GameData.is_in_light = !GameData.is_in_light
		
