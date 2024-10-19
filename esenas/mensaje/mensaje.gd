extends Control
@onready var text_user = $"enviar mensaje/PanelContainer/VBoxContainer/HBoxContainer2/LineEdit"
@onready var id_user = $"enviar mensaje/PanelContainer/VBoxContainer/HBoxContainer3/LineEdit"
@onready var titulo = $"enviar mensaje/PanelContainer/VBoxContainer/Label"
@onready var send_msj = get_tree().get_first_node_in_group("cliente")
@onready var send_msjs = get_tree().get_first_node_in_group("host")
@onready var rpc_local = get_tree().get_first_node_in_group("rpc_local")



func _ready() -> void:
	titulo.text = str(Data.t_id)
	pass # Replace with function body.





func _process(delta: float) -> void:
	pass



func _on_salir_pressed() -> void:
	get_tree().quit()
	pass 


func _on_enviar_pressed() -> void:
	if Data.t_id == 1:
		send_msjs.send_msj(id_user.text.to_int(),text_user.text)
		return
	else:
		send_msj.send_msj(id_user.text.to_int(),text_user.text)
		return
	pass 




func _on_regresar_pressed() -> void:
	rpc_local.nueva_menu()
	queue_free()
	
	pass # Replace with function body.
