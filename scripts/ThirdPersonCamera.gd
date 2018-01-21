extends Camera

var _cutesy

func _ready():
	self._cutesy = get_tree().get_root().get_node("Node/cutesy")
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	set_process_input(true)

func _input(event):
	if(event is InputEventMouseMotion):
		processMouseInputEvent(event)

func processMouseInputEvent(event):
	var cutesyPos = self._cutesy.get_translation()
	var currentPos = self.get_translation()

	var xAngle = event.relative.x
	var horizontalCenter = Vector2(cutesyPos.x, cutesyPos.z)
	var horizontalPoint = Vector2(currentPos.x, currentPos.z)
	var rotatedHorizontal = rotateAroundCenter(horizontalPoint, horizontalCenter, xAngle)
	var horizontalCoordinate = Vector3(rotatedHorizontal.x, currentPos.y, rotatedHorizontal.y)

	self.set_translation(horizontalCoordinate)

	currentPos = self.get_translation()
	var yAngle = event.relative.y
	var verticalCenter = Vector2(cutesyPos.y, cutesyPos.z)
	var verticalPoint = Vector2(currentPos.y, currentPos.z)
	var rotatedVertical = rotateAroundCenter(verticalPoint, verticalCenter, yAngle)
	var verticalCoordinate = Vector3(currentPos.x, rotatedVertical.x, rotatedVertical.y)

	self.set_translation(verticalCoordinate)
	self.look_at(cutesyPos, Vector3(0, 1, 0))

func rotateAroundCenter(point, center, degrees):
	var angle = deg2rad(degrees)
	var rotatedX = cos(angle) * (point.x - center.x) - sin(angle) * (point.y-center.y) + center.x
	var rotatedY = sin(angle) * (point.x - center.x) + cos(angle) * (point.y - center.y) + center.y
	return Vector2(rotatedX, rotatedY)