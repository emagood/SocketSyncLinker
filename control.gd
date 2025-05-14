extends CanvasLayer



@export var total_graph: Panel
@export var frame_history_total_last: Label
@export var frame_history_total_max: Label
const HISTORY_NUM_FRAMES = 150

const GRAPH_SIZE = Vector2(150, 25)
const GRAPH_MIN_FPS = 10
const GRAPH_MAX_FPS = 160
const GRAPH_MIN_FRAMETIME = 1.0 / GRAPH_MIN_FPS
const GRAPH_MAX_FRAMETIME = 1.0 / GRAPH_MAX_FPS
# History of the last `HISTORY_NUM_FRAMES` rendered frames.
var frame_history_total: Array[float] = []
var frame_history_cpu: Array[float] = []
var frame_history_gpu: Array[float] = []
var fps_history: Array[float] = []  # Only used for graphs.

var frametime_avg := GRAPH_MIN_FRAMETIME
var frametime_cpu_avg := GRAPH_MAX_FRAMETIME
var frametime_gpu_avg := GRAPH_MIN_FRAMETIME
var frames_per_second := float(GRAPH_MIN_FPS)
var frame_time_gradient := Gradient.new()
var last_tick := 0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
func _total_graph_draw() -> void:
	var total_polyline := PackedVector2Array()
	total_polyline.resize(HISTORY_NUM_FRAMES)
	for total_index in frame_history_total.size():
		total_polyline[total_index] = Vector2(
				remap(total_index, 0, frame_history_total.size(), 0, GRAPH_SIZE.x),
				remap(clampf(frame_history_total[total_index], GRAPH_MIN_FPS, GRAPH_MAX_FPS), GRAPH_MIN_FPS, GRAPH_MAX_FPS, GRAPH_SIZE.y, 0.0)
		)
	# Don't use antialiasing to speed up line drawing, but use a width that scales with
	# viewport scale to keep the line easily readable on hiDPI displays.
	total_graph.draw_polyline(total_polyline, frame_time_gradient.sample(remap(1000.0 / frametime_avg, GRAPH_MIN_FPS, GRAPH_MAX_FPS, 0.0, 1.0)), 1.0)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var frametime_last := (Time.get_ticks_usec() - last_tick) * 0.001
	var frametime := (Time.get_ticks_usec() - last_tick) * 0.001

	total_graph.queue_redraw()
		
		
			# Difference between the last two rendered frames in milliseconds.
	

	frame_history_total.push_back(frametime)
	if frame_history_total.size() > HISTORY_NUM_FRAMES:
		frame_history_total.pop_front()
		var frametime_max: float = frame_history_total.max()
		frame_history_total_max.text = str(frametime_max).pad_decimals(2)
		frame_history_total_max.modulate = frame_time_gradient.sample(remap(1000.0 / frametime_max, GRAPH_MIN_FPS, GRAPH_MAX_FPS, 0.0, 1.0))

		frame_history_total_last.text = str(frametime).pad_decimals(2)
		frame_history_total_last.modulate = frame_time_gradient.sample(remap(1000.0 / frametime, GRAPH_MIN_FPS, GRAPH_MAX_FPS, 0.0, 1.0))
		
		fps_history.resize(HISTORY_NUM_FRAMES)
		fps_history.fill(1000.0 / frametime_last)
		frame_history_total.resize(HISTORY_NUM_FRAMES)
		frame_history_total.fill(frametime_last)
	_total_graph_draw()
	pass
