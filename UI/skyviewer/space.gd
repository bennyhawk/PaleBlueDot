extends Node3D

@onready var star_field: Node3D = $Stars


func _ready() -> void:
	var http_request = HTTPRequest.new()
	add_child(http_request)
	http_request.request_completed.connect(self._on_request_completed)
	
	var error = http_request.request("https://run.mocky.io/v3/75f35ea3-c57c-48ec-9a32-43ef0593c318")
	if error != OK:
		push_error("An error occurred in the HTTP request.")

	
	
func _on_request_completed(result, response_code, headers, body):
	var json = JSON.new()
	json.parse(body.get_string_from_utf8())
	var response = json.get_data()

	for i in response:
		var nextChild: Star = Star.constructor(i['x'],i['y'],i['z'])
		star_field.add_child(nextChild)
