extends Node

var server_custom = ENetMultiplayerPeer.new()
var multiplayer_api : MultiplayerAPI
var upnp = UPNP.new()
var port = 8888
var max_peers = 5
@onready var rpc_local = get_tree().get_first_node_in_group("rpc_local")



func _ready():
	add_to_group("host")
	print("Custom Server _ready()  Entered" + "  del servidor `port" + str(port))

	server_custom.peer_connected.connect(_on_peer_connected)
	server_custom.peer_disconnected.connect(_on_peer_disconnected)
	multiplayer_api = MultiplayerAPI.create_default_interface()
	server_custom.create_server(port, max_peers)

	get_tree().set_multiplayer(multiplayer_api, self.get_path())
	# can use "/root/ServerCustom" or self.get_path()
	multiplayer_api.multiplayer_peer = server_custom
	#Data.t_id = multiplayer_api.get_unique_id()
	prints(" mi id servidor " + str(Data.t_id))





func _process(_delta: float) -> void:
	if multiplayer_api.has_multiplayer_peer():
		multiplayer_api.poll()




func _on_peer_connected(peer_id):
	#multiplayer.multiplayer_peer.disconnect_peer(peer_id)
	print("Custom Server _on_peer_connected , peer_id: {0}".format([peer_id]) + "  del servidor `port" + str(port))
	await get_tree().create_timer(1).timeout
	print("Custom Peers 8888: {0}".format([multiplayer.get_peers()]) + "  del servidor `port" + str(port))

	var peer = server_custom.get_peer(peer_id)
	
	prints(peer.get_remote_address())



func _on_peer_disconnected(peer_id):
	print("Custom Server _on_peer_disconnected , peer_id: {0}".format([peer_id]) + "  del servidor `port" + str(port))
	





@rpc("any_peer") 
func rpc_server_custom(str):
	var peer_id = multiplayer.get_remote_sender_id() # even custom uses default "multiplayer" calls
	print("rpc_server_custom , peer_id: {0}".format([peer_id]) + "  del servidor `port" + str(port))
	rpc_server_custom_response(peer_id)
	prints("datos del cliente  8888" + "  del servidor `port" + str(port))






@rpc("authority") 
func rpc_server_custom_response(peer_id, test_var1 : String = "bienvenido al servidor ", test_var2 : int = port):
	print("rpc_server_custom_response to peer_id : {0}".format([peer_id]) + "  del servidor `port" + str(port))
	rpc_server_custom_response.rpc_id(peer_id, test_var1, test_var2)







func _input(event: InputEvent) -> void:
	#multiplayer.multiplayer_peer.close()
	if Input.is_key_pressed(KEY_A): prints(str(multiplayer.get_peers()))
	if Input.is_key_pressed(KEY_V) : 
		var idply = multiplayer.get_peers()[0]
		prints(idply)
		var peer = server_custom.get_peer(idply)
		

	pass


@rpc("call_local","any_peer")  
func rpc_sms(test_var1, test_var2):
	var peer_id = multiplayer.get_remote_sender_id() 
	print("Custom servidor rpc_server_all_respons var ",test_var1 , " var 2 ",test_var2)
	rpc_sms.rpc_id(peer_id,"respondo servidor","HOLA")
	#rpc_server_all_response(peer_id,"hola soy servidor",port)
	
	
@rpc("call_local","any_peer") 
func rpc_server_pin(peer_id, test_var1 : int = 0, test_var2 : int = 0):
	prints("del cliente ",test_var1 , " el segundo dato " , test_var2)
	print("all response servidor : {0}".format([peer_id]) + "  del servidor `port" + str(port))
	rpc_server_pin.rpc_id(peer_id, test_var1, test_var2)



	



func send_msj(id,dat):
	rpc_sms.rpc_id(id,dat,"HOLA")
