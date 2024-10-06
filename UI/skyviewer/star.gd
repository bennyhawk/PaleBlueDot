class_name Star extends Node3D

const self_scene = preload("res://star.tscn")

static var x_axis = 0
static var y_axis = 0
static var z_axis = 0


static func constructor(x: int = 0,y: int = 0,z: int = 0)-> Star:
	var obj = self_scene.instantiate()
	x_axis = x
	y_axis = y
	z_axis = z
	return obj


func _ready() -> void:
	self.global_position.x = x_axis
	self.global_position.y = y_axis
	self.global_position.z = z_axis
