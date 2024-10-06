class_name FreeFlyCam extends Camera3D

var move_speed = 40.0
var automove_speed = 1
var look_sensitivity = 0.5

var should_auto_move = false
var should_auto_move_x = false
var should_auto_move_y = false
var should_auto_move_z = false

var auto_move_x = 162.83
var auto_move_y = -20.54
var auto_move_z = 28.47

func set_automove_params(x ,y ,z):
	print("set")
	
	auto_move_x = x
	auto_move_y = y
	auto_move_z = z
	
	should_auto_move_x = true
	should_auto_move_y = true
	should_auto_move_z = true
	
	should_auto_move = true

func _process(delta):
	if not should_auto_move:
		handle_camera_rotation(delta)
		handle_movement(delta)
	else:
		if should_auto_move_x:
			if abs(self.global_position.x - auto_move_x) < 1:
				self.global_position.x = auto_move_x
				should_auto_move_x = false
			elif auto_move_x < self.global_position.x:
				self.global_position.x = (-1 * automove_speed) + self.global_position.x
			else:
				self.global_position.x = automove_speed + self.global_position.x
		
		if should_auto_move_y:
			if abs(self.global_position.y - auto_move_y) < 1:
				self.global_position.y = auto_move_y
				should_auto_move_y = false
			elif auto_move_y < self.global_position.y:
				self.global_position.y = (-1 * automove_speed) + self.global_position.y
			else:
				self.global_position.y = automove_speed + self.global_position.y
		
		if should_auto_move_z:
			if abs(self.global_position.z - auto_move_z) < 1:
				self.global_position.z = auto_move_z
				should_auto_move_z = false
			elif auto_move_z < self.global_position.z:
				self.global_position.z = (-1 * automove_speed) + self.global_position.z
			else:
				self.global_position.z = automove_speed + self.global_position.z
	

func handle_movement(delta):
	var move_direction = Vector3.ZERO
	
	var left_thumb_x = Input.get_action_strength('ui_left') - Input.get_action_strength('ui_right')
	var left_thumb_y = Input.get_action_strength('ui_up') - Input.get_action_strength('ui_down')
	
	move_direction.x = -left_thumb_x * move_speed * delta  # Left-right movement
	move_direction.z = -left_thumb_y * move_speed * delta  # Forward-backward movement

	translate(move_direction)

func handle_camera_rotation(delta):
	var right_thumb_x = Input.get_action_strength('ui_camera_right') - Input.get_action_strength('ui_camera_left')
	rotate_y(-right_thumb_x * look_sensitivity * delta)
	
	var right_thumb_y = Input.get_action_strength('ui_camera_down') - Input.get_action_strength('ui_camera_up')
	var move_direction = Vector3.ZERO
	move_direction.y = -right_thumb_y * move_speed * delta  # Left-right movement
	translate(move_direction)
	
	var rotation_degrees_clamped = rotation_degrees
	rotation_degrees_clamped.x = clamp(rotation_degrees_clamped.x, -89, 89)
	rotation_degrees = rotation_degrees_clamped
