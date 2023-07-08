extends Label

var initial_time: float = 0

func _ready():
	initial_time = Time.get_ticks_msec() / 1000.0

func _process(_delta):
	var seconds: float = Time.get_ticks_msec() / 1000.0 - initial_time
	text = "%d" % ceil(seconds)
