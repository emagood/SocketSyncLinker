extends Control
@onready var text_user = $"enviar mensaje/PanelContainer/VBoxContainer/HBoxContainer2/LineEdit"
@onready var id_user = $"enviar mensaje/PanelContainer/VBoxContainer/HBoxContainer3/LineEdit"
@onready var titulo = $"enviar mensaje/PanelContainer/VBoxContainer/Label"
@onready var botton_send = $"enviar mensaje/CheckButton"
@onready var send_msj = get_tree().get_first_node_in_group("cliente")
@onready var send_msjs = get_tree().get_first_node_in_group("host")
@onready var rpc_local = get_tree().get_first_node_in_group("rpc_local")



func _ready() -> void:
	titulo.text = str(Data.t_id)
	pass 





func _process(delta: float) -> void:
	pass



func _on_salir_pressed() -> void:
	get_tree().quit()
	pass 


func _on_enviar_pressed() -> void:
	if Data.t_id.is_empty() :
			prints(Data.t_id)
			return
	
	
	if  Data.t_id.has(1):
		if botton_send.button_pressed == true :
			send_msjs.send_msja(id_user.text.to_int(),text_user.text)
			
		send_msjs.send_msj(id_user.text.to_int(),text_user.text)
		return
	
	else:
		if botton_send.button_pressed == true :
			send_msj.send_msja(2,text_user.text)
		send_msj.send_msj(id_user.text.to_int(),text_user.text)
		return
	
	pass 




func _on_regresar_pressed() -> void:
	rpc_local.nueva_menu()
	queue_free()
	
	pass
