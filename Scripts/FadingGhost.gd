extends AnimatedSprite


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var tween = get_node("%Tween")

# Called when the node enters the scene tree for the first time.
func _ready():
	var rand_x = rand_range(0, 800)
	var rand_y = rand_range(0, 600)
	tween.interpolate_property(self, "position", 
		self.position, Vector2(rand_x, rand_y), 2, 
		Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tween.interpolate_property(self, "modulate:a", 
		1.0, 0.0, 2, 
		Tween.TRANS_LINEAR, Tween.EASE_IN_OUT) 		
	tween.start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Tween_tween_all_completed():
	self.queue_free()
