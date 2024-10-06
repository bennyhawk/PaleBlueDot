class_name Planet extends Node3D

const self_scene = preload("res://planet.tscn")

static var x_axis = 0
static var y_axis = 0
static var z_axis = 0

signal on_exoplanet_clicked(x, y, z)

static func constructor(x: int = 0,y: int = 0,z: int = 0)-> Planet:
	var obj = self_scene.instantiate()
	x_axis = x
	y_axis = y
	z_axis = z
	return obj


func _ready() -> void:
	self.global_position.x = x_axis
	self.global_position.y = y_axis
	self.global_position.z = z_axis
	
	line_material = StandardMaterial3D.new()
	line_material.albedo_color = Color(1, 1, 1)
	line_material.emission_enabled = true
	line_material.emission = Color(1, 1, 1) # Set the emission color (white)
	line_material.emission_energy = 0.3     # Set the intensity of the emission
	
	for i in range(1, segments - 1):
		var lat_angle = PI * float(i) / float(segments - 1)
		add_latitude_line(lat_angle)

	for i in range(segments):
		var lon_angle = TAU * float(i) / float(segments)
		add_longitude_line(lon_angle)


func _on_area_3d_input_event(camera: Node, event: InputEvent, event_position: Vector3, normal: Vector3, shape_idx: int) -> void:
	print("Emitted")
	on_exoplanet_clicked.emit(event_position.x, event_position.y, event_position.z)


# Sphere settings
var sphere_radius = 0.51
var segments = 36

# Line material
var line_material = null



func add_latitude_line(lat_angle):
	var points = []
	for i in range(segments + 1):
		var lon_angle = TAU * float(i) / float(segments)
		var x = sphere_radius * sin(lat_angle) * cos(lon_angle)
		var y = sphere_radius * cos(lat_angle)
		var z = sphere_radius * sin(lat_angle) * sin(lon_angle)
		points.append(Vector3(x, y, z))
	create_line(points)

func add_longitude_line(lon_angle):
	var points = []
	for i in range(segments + 1):
		var lat_angle = PI * float(i) / float(segments)
		var x = sphere_radius * sin(lat_angle) * cos(lon_angle)
		var y = sphere_radius * cos(lat_angle)
		var z = sphere_radius * sin(lat_angle) * sin(lon_angle)
		points.append(Vector3(x, y, z))
	
	create_line(points)

func create_line(points):
	var mesh = ImmediateMesh.new()
	mesh.surface_begin(Mesh.PRIMITIVE_LINE_STRIP, line_material)
	
	for point in points:
		mesh.surface_add_vertex(point)
	
	mesh.surface_end()
	
	
	var line_instance = MeshInstance3D.new()
	
	line_instance.mesh = mesh
	add_child(line_instance)
