extends Control
@onready var text_user = $"enviar mensaje/PanelContainer/VBoxContainer/HBoxContainer2/LineEdit"
@onready var id_user = $"enviar mensaje/PanelContainer/VBoxContainer/HBoxContainer3/LineEdit"
@onready var titulo = $"enviar mensaje/PanelContainer/VBoxContainer/Label"
@onready var botton_send = $"enviar mensaje/CheckButton"
@onready var send_msj = get_tree().get_first_node_in_group("cliente")
@onready var send_msjs = get_tree().get_first_node_in_group("host")
@onready var rpc_local = get_tree().get_first_node_in_group("rpc_local")
@onready var nscroll = $"enviar mensaje/Panel/sdcrol"
@onready var nmsj_label = $"enviar mensaje/Panel/sdcrol/Label"
@export var msj_entra = "bienvenidos" +  "\n"
@export var soze = 40



func _ready() -> void:
	add_to_group("msj")
	titulo.text = str(Data.t_id)
	if Data.external_ip != "" :
		$"enviar mensaje/CheckButton/Label".text = Data.external_ip
	pass 





func _process(delta: float) -> void:
	nscroll.scroll_vertical = 1000
	if msj_entra != "":
		nscroll.scroll_vertical += soze
		nmsj_label.text += str(msj_entra) +" para  " + str(Data.t_id.keys()) + "\n"
		#nmsj_label.text += "\n"
		msj_entra = ""
	
	
	if nmsj_label.text.length() >= 1500:
		prints("mensage largo")
		nmsj_label.text = ""




func _on_salir_pressed() -> void:
	get_tree().quit()
	pass 


func _on_enviar_pressed() -> void:
	nmsj_label.text += str(text_user.text) +"  " + str(Data.t_id.keys()) + "\n"

	if Data.t_id.is_empty() :
			prints(Data.t_id)
			return
	
	
	if  Data.t_id.has(1):
		if botton_send.button_pressed == true :
			send_msjs.send_msja(text_user.text,1)
		elif id_user.text != "":
			
			send_msjs.send_msj(id_user.text.to_int(),text_user.text,1)
		else:
			return
	
	else:
		if botton_send.button_pressed == true :
			send_msj.send_msja(text_user.text,2)
		else:
			send_msj.send_msj(id_user.text.to_int(),text_user.text,1)
		return
	
	pass 




func _on_regresar_pressed() -> void:
	rpc_local.nueva_menu()
	queue_free()
	
	pass
