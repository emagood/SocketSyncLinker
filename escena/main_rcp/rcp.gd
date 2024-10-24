
'''
	mejorar el t_id identificador por un diccionario 
	admitir varios usuarios abrir el id 
	mover host_local a datos globales

'''
extends Control

const SERVER_PORT = 8888
var thread = null
@onready var port = 8888
@onready var ip_local = "127.0.0.1"
@onready var host_local = {}
var upnp = UPNP.new()


func _ready() -> void:
	var inf = class_info.new()
	prints(inf.info())
	thread = Thread.new()
	add_to_group("rpc_local")
	nueva_menu()
	
	pass 



func _process(delta: float) -> void:
	pass
	


func _upnp_setup(server_port):
	prints("upnp setup iniciando")
	var err = upnp.discover()
	if err != OK:
		push_error(str(err))
		emit_signal("upnp_completed", err)
		return
	if upnp.get_gateway() and upnp.get_gateway().is_valid_gateway():
		upnp.add_port_mapping(server_port, server_port, ProjectSettings.get_setting("application/config/name"), "UDP")
		#upnp.add_port_mapping(server_port, server_port, ProjectSettings.get_setting("application/config/name"), "TCP")
		print("Success! Join Address: %s" % upnp.query_external_address())




func nueva_red(port,ip):
	if Data.t_id.is_empty():
		var player = preload("res://escena/red/cliente/cliente.tscn").instantiate()
		player.port = port
		player.address = ip
		add_child(player)
		prints("instancio escena")
		await get_tree().create_timer(3).timeout
	pass





func nueva_host(port):
	if host_local.has(port):
		prints("existe el puerto del host")
		return
	host_local[port] = true
	prints("servidor")
	var player = preload("res://escena/red/host/servidor.tscn").instantiate()
	player.port = port
	add_child(player)
	thread.start(_upnp_setup.bind(SERVER_PORT))
	prints("instancio escena")
	await get_tree().create_timer(3).timeout
	pass






func _input(event: InputEvent) -> void:
	if Input.is_key_pressed(KEY_W): nueva_red(8888,"127.0.0.1")
	#if Input.is_key_pressed(KEY_S): nueva_host(8888)
	#if Input.is_key_pressed(KEY_M): nueva_msj()
	
	pass






func nueva_menu():
	prints("servidor")
	var player = preload("res://escena/red/menu/menu.tscn").instantiate()
	add_child(player)
	prints("instancio escena")
	await get_tree().create_timer(3).timeout
	pass

func nueva_msj():
	prints("servidor")
	var player = preload("res://escena/mensaje/mensaje.tscn").instantiate()
	add_child(player)
	prints("instancio escena")
	await get_tree().create_timer(3).timeout
	pass




func _exit_tree():
	prints("exit script")
	thread.wait_to_finish()
	upnp.delete_port_mapping(port)
	
