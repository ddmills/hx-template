package data.input.groups;

import common.struct.Coordinate;
import core.Game;
import core.input.Command;
import ecs.Entity;

class CameraInputGroup
{
	var follow:Null<Entity>;

	public function new()
	{
		follow = null;
	}

	public function onMouseMove(pos:Coordinate, previous:Coordinate)
	{
		var game = Game.instance;

		if (game.input.mmb)
		{
			var diff = previous
				.sub(pos)
				.toFloatPoint()
				.multiply(1);

			game.camera.scroller.x -= diff.x;
			game.camera.scroller.y -= diff.y;

			follow = null;
		}
	}

	public function onMouseWheelDown(wheelDelta:Float)
	{
		var game = Game.instance;
		var z = (game.camera.zoom + .1).clamp(.1, 4);
		game.camera.zoomTo(game.input.mouse, z);
	}

	public function onMouseWheelUp(wheelDelta:Float)
	{
		var game = Game.instance;
		var z = (game.camera.zoom - .1).clamp(.1, 4);
		game.camera.zoomTo(game.input.mouse, z);
	}

	public function followEntity(entity:Entity)
	{
		follow = entity;
	}

	public function update()
	{
		if (follow != null)
		{
			if (follow.isDestroyed)
			{
				follow = null;
			}
			else
			{
				Game.instance.camera.focus = follow.pos;
			}
		}
	}

	public function handle(command:Command)
	{
		var world = Game.instance.world;

		switch (command.type)
		{
			case CMD_PAUSE:
				world.clock.isPaused = !world.clock.isPaused;
			case CMD_SPEED_1:
				world.clock.speed = .5;
				world.clock.isPaused = false;
			case CMD_SPEED_2:
				world.clock.speed = 1;
				world.clock.isPaused = false;
			case CMD_SPEED_3:
				world.clock.speed = 2;
				world.clock.isPaused = false;
			case CMD_SPEED_4:
				world.clock.speed = 3;
				world.clock.isPaused = false;
			case _:
		}
	}
}
