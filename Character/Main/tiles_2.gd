extends TileMapLayer
@onready var anim_main = $"../anim main"

@onready var anim = $anim

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func peace():
	if anim.current_animation == 'peace':
		pass
	else :
		anim.play('peace')
func war():
	if anim.animation_changed:
		pass
	else :
		anim.play('war')
func idle():
	if anim.current_animation == 'idle':
		pass
	else :
		anim.play('idle')
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
