extends Node

var client_custom = ENetMultiplayerPeer.new()
var multiplayer_api : MultiplayerAPI
var rpc_true = false
var address = "127.0.0.1"
var port = 8888


func _ready():
	
	
	
	print("Custom Client _ready() Entere8888")
	add_to_group("cliente")


	client_custom.create_client(address, port)
	multiplayer_api = MultiplayerAPI.create_default_interface()
	get_tree().set_multiplayer(multiplayer_api, self.get_path()) 
	multiplayer_api.multiplayer_peer = client_custom
	multiplayer_api.connected_to_server.connect(_on_connection_succeeded)
	multiplayer_api.connection_failed.connect(_on_connection_failed)
	multiplayer_api.server_disconnected.connect(_on_server_disconnected)
	print("Custom ClientUnique ID: {0}".format([multiplayer_api.get_unique_id()]))
	Data.t_id = multiplayer_api.get_unique_id()
	await get_tree().create_timer(1).timeout






func _process(_delta: float) -> void:
	if multiplayer_api.has_multiplayer_peer():
		multiplayer_api.poll()




func _on_server_disconnected():
	rpc_true = false
	Data.t_id = null
	print("se desconecto el servidor")



func _on_connection_succeeded():
	rpc_true = true
	print("Custom Client _on_connection_succeeded")
	await get_tree().create_timer(1).timeout
	print("Custom Peers: {0}".format([multiplayer.get_peers()]))
	Data.t_id = multiplayer_api.get_unique_id()
	#rpc_server_custom("hola")



func _on_connection_failed():
	rpc_true = false
	print("Custom Client _on_connection_failed")



@rpc
func rpc_server_custom(str):
	print("Custom Client rpc_server_custom")
	print("Custom Peers: {0}".format([multiplayer.get_peers()]))
	rpc_server_custom.rpc("hola") # this works (NO MORE STRINGS!)



@rpc("authority") 
func rpc_server_custom_response(test_var1, test_var2):
	print("Custom Client rpc_server_custom_response: {0} {1}".format(
		[test_var1, test_var2]))



@rpc("any_peer","call_local") 
func rpc_sms(test_var1, test_var2):
	prints(test_var1 , test_var2)
	var peer_id = multiplayer.get_remote_sender_id() 
	rpc_server_all_response(peer_id,"soy el cliente",port)
	prints("cliente del all response del sccript cliente ",test_var1 , "  el otro dato " , test_var2)
	#print("llamada all any peer: {0} {1}".format(
		#[test_var1, test_var2]))



@rpc ("any_peer","call_local")
func rpc_server_all_response(peer_id, test_var1 = "gola", test_var2  = port):
	#peer_id = multiplayer.get_remote_sender_id() 
	prints(peer_id, "   datos response cliente" , test_var2 , "  fall " , test_var1)
	prints(" del lado del cliente    cliente    " + str(peer_id))
	#




func _input(event: InputEvent) -> void:
	if rpc_true == true : 
		var ema = {"ema" : "gfvhjgijgihj",
		"loby" : "user",
	"gorro" : "falso",
	"cliente" : str("holka desde el clinte  " + str(multiplayer_api.get_unique_id()))
	}

	if Input.is_key_pressed(KEY_A): queue_free()
	if Input.is_key_pressed(KEY_D) and rpc_true == true:
		multiplayer.multiplayer_peer.disconnect_peer(1)





	#client_custom.create_client(address, port)#
	if Input.is_key_pressed(KEY_N) and rpc_true == false:
		cliente_rcp(address,port)
		prints("crear")





func cliente_rcp(address , port) :
	if !multiplayer_api.has_multiplayer_peer():
		multiplayer_api = MultiplayerAPI.create_default_interface()
		prints("cliente creado")
		return
	if rpc_true == true:
		return
	client_custom.create_client(address, port)
	get_tree().set_multiplayer(multiplayer_api, self.get_path()) 
	multiplayer_api.multiplayer_peer = client_custom
	multiplayer_api.connected_to_server.connect(_on_connection_succeeded)
	multiplayer_api.server_disconnected.connect(_on_connection_failed)
	print("Custom ClientUnique ID: {0}".format([multiplayer_api.get_unique_id()]))
	await get_tree().create_timer(1).timeout






func send_msj(id,dat):
	rpc_sms.rpc_id(id,dat,"HOLA")
