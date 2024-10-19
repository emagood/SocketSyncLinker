extends class_code
class_name class_thread
var data_thread = {
	"hola" : "emanuel",
	"genio": "servidor"
}

var thread: Thread
var thread2: Thread
var timer_local = 0
var timer_local2 = 0



func _ready():
	thread = Thread.new()
	thread2 = Thread.new()
	timer_local = Time.get_ticks_msec()
	timer_local2 = timer_local
	prints(Time.get_ticks_msec())
	# You can bind multiple arguments to a function Callable.
	thread.start(_thread_function.bind(data_thread))
	thread2.start(_thread_function.bind(data_thread))
	


# Run here and exit.
# The argument is the bound data passed from start().
func _thread_function(userdata):
	var a = 1000
	while a :
		prints("abuelo")
		if userdata.has("hola"):
			prints("ema")
		#if userdata.has("genio"):
			#prints("genio")
		a -= 1



	print("I'm a thread! Userdata is: ", userdata)
	prints(Time.get_ticks_msec())
	timer_local = Time.get_ticks_msec() 
	prints("el tiempo paso " + str(timer_local - timer_local2))



func _exit_tree():
	prints("tread")
	thread.wait_to_finish()
	thread2.wait_to_finish()






func _input(event: InputEvent) -> void:
	if Input.is_key_pressed(KEY_W): 
			thread.wait_to_finish()
			thread = Thread.new()
			thread.start(_thread_function.bind("Wafflecopter"))
			thread2.wait_to_finish()
			thread2 = Thread.new()
			thread2.start(_thread_function.bind("Wafflecopter"))
