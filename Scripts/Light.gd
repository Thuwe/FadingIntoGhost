extends StaticBody2D
class_name Torch

onready var light_2D = get_node("%Light2D")
onready var light_area = get_node("%LightArea")

# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimatedSprite.play("default")

func desactivate_light() -> void:
	$AnimatedSprite.play("off")
	light_2D.visible = false
	light_area.monitoring = false
	
func activate_light() -> void:
	$AnimatedSprite.play("default")
	light_2D.visible = true
	light_area.monitoring = true
