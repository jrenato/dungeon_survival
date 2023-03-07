extends AudioStreamPlayer2D
class_name RandomStreamPlayerComponent

@export var streams : Array[AudioStream]
@export var randomize_pitch : bool = false
@export var min_pitch : float = 0.9
@export var max_pitch : float = 1.1


func play_random():
	if streams == null || streams.size() == 0:
		return

	stream = streams.pick_random()

	if randomize_pitch:
		pitch_scale = randf_range(min_pitch, max_pitch)

	play()
