extends Spatial

var MOVE_FORWARD = "move_forward"
var MOVE_BACK = "move_back"
var ESCAPE = "escape"
var RUN_FORWARD = "runForward"
var RUNNING_DISPLACEMENT_PER_SECOND = 50
var ANIMATION_PLAYER_INDEX = 1
var RUN_ANIMATION_SPEED = 2
var _forward = Vector3(0, 0, 1)
var _animPlayer

func _ready():
	set_process(true)
	self._animPlayer = self.get_child(ANIMATION_PLAYER_INDEX)
	self._animPlayer.set_current_animation(RUN_FORWARD)
	self._animPlayer.get_animation(RUN_FORWARD).set_loop(true)
	self._animPlayer.stop()

func _process(delta):
	pollKeyboard(delta)

func pollKeyboard(delta):
	if(Input.is_action_just_pressed(ESCAPE)):
		self.get_tree().quit()

	if(Input.is_action_just_pressed(MOVE_FORWARD)):
		self._animPlayer.play(RUN_FORWARD, -1, RUN_ANIMATION_SPEED)
	elif(Input.is_action_pressed(MOVE_FORWARD)):
		var displacement = RUNNING_DISPLACEMENT_PER_SECOND * delta
		self.translate(displacement * _forward)
		self._animPlayer.advance(delta)
	elif(Input.is_action_just_released(MOVE_FORWARD)):
		self._animPlayer.stop()
		self._animPlayer.seek(0, true)
	if(Input.is_action_just_pressed(MOVE_BACK)):
		self._animPlayer.play_backwards(RUN_FORWARD)
	elif(Input.is_action_pressed(MOVE_BACK)):
		var displacement = -RUNNING_DISPLACEMENT_PER_SECOND * delta
		self.translate(displacement * _forward)
		self._animPlayer.advance(delta)
	elif(Input.is_action_just_released(MOVE_BACK)):
		self._animPlayer.stop()
		self._animPlayer.seek(0, true)