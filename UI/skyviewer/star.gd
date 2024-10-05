class_name Star extends Node3D

const self_scene = preload("res://star.tscn")

static func constructor(x_axis: int = 0,y_axis: int = 0,z_axis: int = 0)-> Star:
	var obj = self_scene.instantiate()
	var vec = Vector3()
	vec.x = x_axis
	vec.y = y_axis
	vec.z = z_axis
	obj.translate(vec)
	return obj
