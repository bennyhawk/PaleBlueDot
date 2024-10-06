extends Node3D

@onready var star_field: Node3D = $Stars
@onready var exoplanet: Node3D = $Exoplanets
@onready var resetCamera: MenuButton = $Menu/HBoxContainer/VBoxContainer/ResetCamera
@onready var landOnPlanet: MenuButton = $Menu/HBoxContainer/VBoxContainer/LandOnPlanet
@onready var takeOff: MenuButton = $Menu/HBoxContainer/VBoxContainer/TakeOff
@onready var planetName: Label = $Menu/HBoxContainer/PlanetName
@onready var camera: FreeFlyCam = $FreeCamera

var stored = preload("res://new_json.tres")
	
func _ready() -> void:
	resetCamera.pressed.connect(reset_camera)
	
	var star_field_data = HTTPRequest.new()
	add_child(star_field_data)
	star_field_data.request_completed.connect(self._on_get_star_field_data)
	var star_field_data_error = star_field_data.request("https://run.mocky.io/v3/75f35ea3-c57c-48ec-9a32-43ef0593c318")
	if star_field_data_error != OK:
		push_error("An error occurred in the HTTP request.")
		
	var exoplanet_data = HTTPRequest.new()
	add_child(exoplanet_data)
	exoplanet_data.request_completed.connect(self._on_get_exoplanet_data)
	var exoplanet_data_error = exoplanet_data.request("https://run.mocky.io/v3/f982f724-245e-4b9e-a8c4-10d43c927699")
	if exoplanet_data_error != OK:
		push_error("An error occurred in the HTTP request.")
	
	planetName.text = "Current planet: Earth"


func _on_get_star_field_data(result, response_code, headers, body):
	#var json = JSON.new()
	#json.parse(body.get_string_from_utf8())
	#var response = json.get_data()
	
	var response = stored.data

	for i in response:
		var nextChild: Star = Star.constructor(i['x'],i['y'],i['z'])
		
		star_field.add_child(nextChild)

func _on_exoplanet_clicked(x, y, z):
	print("recieved")
	camera.set_automove_params(x - 15, y - 15, z - 15)


func _on_get_exoplanet_data(result, response_code, headers, body):
	var json = JSON.new()
	json.parse(body.get_string_from_utf8())
	var response = json.get_data()

	for i in response:
		var nextChild: Planet = Planet.constructor(i['x'],i['y'],i['z'])
		nextChild.connect('on_exoplanet_clicked', _on_exoplanet_clicked)
		exoplanet.add_child(nextChild)
		

func reset_camera():
	camera.global_position.x = -10
	camera.global_position.y = 0
	camera.global_position.z = 0
	camera.global_rotation_degrees.x = 0
	camera.global_rotation_degrees.y = -90
	camera.global_rotation_degrees.z = 0
