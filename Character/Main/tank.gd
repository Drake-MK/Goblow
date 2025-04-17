extends Node2D

@onready var _1 = $"left/1"
@onready var _2 = $"left/2"
@onready var _3 = $"right/1"
@onready var _4 = $"right/2"

func tank_color(amount := 0.1):
	_1.modulate = adjust_color(_1.modulate, amount)
	_2.modulate = adjust_color(_2.modulate, amount)
	_3.modulate = adjust_color(_3.modulate, amount)
	_4.modulate = adjust_color(_4.modulate, amount)

func adjust_color(c: Color, amount: float) -> Color:
	c.r = clamp(c.r + amount, 0.0, 1.0)
	c.g = clamp(c.g - amount, 0.0, 1.0)
	c.b = clamp(c.b - amount, 0.0, 1.0)
	return c
