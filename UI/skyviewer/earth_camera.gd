class_name EarthCamera extends Camera3D

var move_speed = 40.0
var automove_speed = 1
var look_sensitivity = 25

func _process(delta):
	handle_movement(delta)
	

func handle_movement(delta):
	var move_direction = Vector3.ZERO
	
	var left_thumb_x = Input.get_action_strength('ui_left') - Input.get_action_strength('ui_right')
	#rotate_y(left_thumb_x * look_sensitivity * delta)
	global_rotation_degrees.y += left_thumb_x * look_sensitivity * delta
	
	var left_thumb_y = Input.get_action_strength('ui_up') - Input.get_action_strength('ui_down')
	#rotate_x(-left_thumb_y * look_sensitivity * delta)
	global_rotation_degrees.x += left_thumb_y * look_sensitivity * delta
	
	var right_thumb_x = Input.get_action_strength('ui_camera_up') - Input.get_action_strength('ui_camera_down')
	self.fov = self.fov - right_thumb_x 
	#rotate_y(-right_thumb_x * look_sensitivity * delta)
	
