extends LightOccluder2D

@onready var body = $"."

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	var body_new = OccluderPolygon2D.new()
	var shape = get_parent()
	body_new.polygon = shape.polygon
	body.occluder = body_new
	print(shape)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
