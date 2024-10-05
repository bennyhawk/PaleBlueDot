extends Camera3D

var move_speed = 40.0
var look_sensitivity = 0.5

func _process(delta):
	handle_camera_rotation(delta)
	handle_movement(delta)
	

func handle_movement(delta):
	var move_direction = Vector3.ZERO
	
	var left_thumb_x = Input.get_action_strength('ui_left') - Input.get_action_strength('ui_right')
	var left_thumb_y = Input.get_action_strength('ui_up') - Input.get_action_strength('ui_down')
	
	move_direction.x = -left_thumb_x * move_speed * delta  # Left-right movement
	move_direction.z = -left_thumb_y * move_speed * delta  # Forward-backward movement

	translate(move_direction)

func handle_camera_rotation(delta):
	var right_thumb_x = Input.get_action_strength('ui_camera_right') - Input.get_action_strength('ui_camera_left')
	var right_thumb_y = Input.get_action_strength('ui_camera_down') - Input.get_action_strength('ui_camera_up')

	rotate_y(-right_thumb_x * look_sensitivity * delta)  # Horizontal rotation (yaw)
	rotate_x(-right_thumb_y * look_sensitivity * delta)  # Vertical rotation (pitch)
	
	var rotation_degrees_clamped = rotation_degrees
	rotation_degrees_clamped.x = clamp(rotation_degrees_clamped.x, -89, 89)
	rotation_degrees = rotation_degrees_clamped
