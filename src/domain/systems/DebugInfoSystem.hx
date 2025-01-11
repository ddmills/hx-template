package domain.systems;

import common.struct.Coordinate;
import common.struct.Set;
import core.Frame;
import data.Data;
import data.core.ColorKey;
import domain.components.Label;
import ecs.Query;
import ecs.System;
import h2d.Object;
import h2d.Text;
import haxe.EnumTools;

typedef DebugInfo =
{
	ob:Object,
	fps:Text,
	pos:Text,
	clock:Text,
	entities:Text,
	drawCalls:Text,
}

class DebugInfoSystem extends System
{
	public var debugInfo:DebugInfo;

	public function new()
	{
		renderDebugInfo();
	}

	override function update(frame:Frame)
	{
		var w = game.input.mouse.toWorld().toIntPoint();
		var px = game.input.mouse.toPx().floor().toString();
		var wtext = w.toString();
		var fps = frame.fps.floor();

		debugInfo.fps.text = game.app.engine.fps.floor().toString() + ' ' + frame.fps.floor().toString();
		debugInfo.fps.color = getFpsColor(fps).toHxdColor();
		debugInfo.pos.text = '$wtext $px Z(${game.camera.zoom})';
		debugInfo.entities.text = 'entities ${game.registry.size.toString()}';
		debugInfo.clock.text = '${world.clock.tick.floor()} (${world.clock.speed})';
		debugInfo.drawCalls.text = 'draw ${game.app.engine.drawCalls}';
	}

	function getFpsColor(fps:Int):Int
	{
		if (fps < 60)
		{
			return 0xbe7474;
		}

		if (fps < 100)
		{
			return 0xe0de62;
		}

		return 0x92e08b;
	}

	override function teardown()
	{
		debugInfo.ob.remove();
	}

	private function renderDebugInfo()
	{
		var ob = new Object();
		ob.x = 16;
		ob.y = 16;

		var fps = Data.Fonts.text(FNT_BIZCAT, ob);
		fps.y = 0;

		var pos = Data.Fonts.text(FNT_BIZCAT, ob);
		pos.color = ColorKey.C_WHITE.toHxdColor();
		pos.y = 16;

		var entities = Data.Fonts.text(FNT_BIZCAT, ob);
		entities.color = ColorKey.C_WHITE.toHxdColor();
		entities.y = 32;

		var clock = Data.Fonts.text(FNT_BIZCAT, ob);
		clock.color = ColorKey.C_WHITE.toHxdColor();
		clock.y = 48;

		var drawCalls = Data.Fonts.text(FNT_BIZCAT, ob);
		drawCalls.color = ColorKey.C_WHITE.toHxdColor();
		drawCalls.y = 64;

		debugInfo = {
			ob: ob,
			fps: fps,
			pos: pos,
			entities: entities,
			clock: clock,
			drawCalls: drawCalls,
		};

		game.render(HUD, ob);
	}
}
