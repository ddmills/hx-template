package domain;

import core.Frame;
import domain.systems.DebugInfoSystem;

class SystemManager
{
	public var debugInfo(default, null):DebugInfoSystem;

	public function new() {}

	public function initialize()
	{
		debugInfo = new DebugInfoSystem();
	}

	public function update(frame:Frame)
	{
		debugInfo.update(frame);
	}

	public function teardown()
	{
		debugInfo.teardown();
	}
}
