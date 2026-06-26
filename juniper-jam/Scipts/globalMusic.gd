extends AudioStreamPlayer2D

const BGM = preload("res://Audio/Puzzle-Game-3_Looping-1.ogg")

func _play_music(music: AudioStream, volume = 0.0):
	if stream == music:
		return
	
	stream = music
	volume_db = volume
	play()

func play_music_level():
	_play_music(BGM)
