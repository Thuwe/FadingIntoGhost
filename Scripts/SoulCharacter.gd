extends KinematicBody2D

signal faded

# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimatedSprite.play("default")

func _physics_process(_delta):
	var collision:KinematicCollision2D = null
	var direction:Vector2 = Vector2(0.0, 0.0)
	var make_move:bool = false
	if GameData.fading_level <= int((GameData.default_fading) / 2):
		self.set_collision_mask_bit(2, false)
	else:
		self.set_collision_mask_bit(2, true)
	if Input.is_action_just_pressed("go_right"):
		direction = Vector2(16.0, 0.0)
		make_move = true
	elif Input.is_action_just_pressed("go_left"):
		direction = Vector2(-16.0, 0.0)
		make_move = true
	elif Input.is_action_just_pressed("go_down"):
		direction = Vector2(0.0, 16.0)
		make_move = true
	elif Input.is_action_just_pressed("go_up"):
		direction = Vector2(0.0, -16.0)
		make_move = true

	if make_move:
		collision = move_and_collide(direction, true, true, true)
		if collision == null:
			collision = move_and_collide(direction)
			if GameData.is_in_light:
				GameData.fading_level -= 1
				print(GameData.fading_level)
				change_visibility(GameData.fading_level)
				if GameData.fading_level <= 0:
					emit_signal("faded")
		else:
			if collision.collider.is_in_group("Switch"):
				collision.collider.change_state()
					
func change_visibility(level:int) -> void:
	var new_value:float = float(level) / float(GameData.default_fading)
	self.modulate.a = new_value

