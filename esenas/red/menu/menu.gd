extends Control

@onready var rpc_local = get_tree().get_first_node_in_group("rpc_local")
@onready var user_login = $CanvasLayer/PanelContainer/VBoxContainer/HBoxContainer2/LineEdit
@onready var user_pass = $CanvasLayer/PanelContainer/VBoxContainer/HBoxContainer3/LineEdit
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if Data.id_user != "": 
		user_login.text = Data.id_user
	if Data.id_pass != "":
		user_pass.text = Data.id_pass
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_regresar_pressed() -> void:
	queue_free()
	pass # Replace with function body.


func _on_login_pressed() -> void:
	prints(user_login.text , "  " , user_pass.text)
	Data.id_user = user_login.text
	Data.id_pass = user_pass.text
	rpc_local.nueva_red(8888 , "127.0.0.1")
	rpc_local.nueva_msj()
	queue_free()
	pass # Replace with function body.


func _on_salir_pressed() -> void:
	get_tree().quit()
	pass # Replace with function body.
