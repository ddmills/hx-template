package data.input;

import data.input.groups.CameraInputGroup;

class InputGroups
{
	public var camera(default, null):CameraInputGroup;

	public function new()
	{
		camera = new CameraInputGroup();
	}
}
