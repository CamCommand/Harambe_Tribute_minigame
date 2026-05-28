extends CanvasLayer

var float_time := 0.0
var float_amplitude := 8.0
var float_speed := 2.0
@onready var harambe: AnimatedSprite2D = $Background1/Harambe

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	float_time += delta
	var float_rng := RandomNumberGenerator.new()
	float_rng.randomize()
	
	harambe.set_meta("float_amplitude", 10) # pixels
		
	# Store original Y once
	if not harambe.has_meta("base_y"):
		harambe.set_meta("base_y", harambe.position.y)
	
	var base_y = harambe.get_meta("base_y")
	harambe.position.y = base_y + sin(float_time * float_speed) * float_amplitude
