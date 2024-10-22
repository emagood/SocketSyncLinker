extends TextureRect
@onready var title = $title


func _ready() -> void:
	
	pass 


func _process(delta: float) -> void:
	
	pass


func _on_button_pressed() -> void:
	self.flip_h = !self.flip_h
	pass # Replace with function body.
