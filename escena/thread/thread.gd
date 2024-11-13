extends Node


var data_thread = {
	"hola": "emanuel",
	"genio": "servidor"
}

var thread: Thread
var thread2: Thread
var timer_local = 0
var timer_local2 = 0

func _init():
	thread = Thread.new()
	thread2 = Thread.new()
	timer_local = Time.get_ticks_msec()
	timer_local2 = timer_local

func _ready():
	# Iniciar threads con datos vinculados
	start_threads()
	prints("Threads iniciados.")

func start_threads():
	if thread == null or not thread.is_alive():
		thread = Thread.new()
		thread.start(_thread_function.bind(data_thread))
	if thread2 == null or not thread2.is_alive():
		thread2 = Thread.new()
		thread2.start(_thread_function.bind(data_thread))

func stop_threads():
	if thread != null and thread.is_alive():
		thread.call_deferred("wait_to_finish")
		thread = null
	if thread2 != null and thread2.is_alive():
		thread2.call_deferred("wait_to_finish")
		thread2 = null
	prints("Threads detenidos.")

func restart_threads():
	stop_threads()
	start_threads()
	prints("Threads reiniciados.")

# Función que ejecutará cada thread
func _thread_function(userdata):
	var a = 10
	while a:
		prints("abuelo")
		if userdata.has("hola"):
			prints("ema")
		a -= 1

	prints("Soy un thread! Los datos de usuario son: ", userdata)
	timer_local = Time.get_ticks_msec()
	prints("El tiempo pasó: " + str(timer_local - timer_local2) + " ms")

func _exit_tree():
	stop_threads()
	prints("Esperando a que los threads terminen.")

func _input(event: InputEvent) -> void:
	if Input.is_key_pressed(KEY_W):
		restart_threads()
