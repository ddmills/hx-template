package screens.console;

import core.Frame;
import core.Screen;
import core.input.KeyCode;
import data.core.Keybinding;
import h2d.Bitmap;
import h2d.Tile;

class ConsoleScreen extends Screen
{
	var root:h2d.Bitmap;

	public function new()
	{
		root = new h2d.Bitmap();
	}

	override function onEnter()
	{
		trace('enter console screen');
		root.addChild(game.console);
		game.render(HUD, root);
		game.console.show();
	}

	override function onDestroy()
	{
		game.console.hide();
		root.removeChildren();
		root.remove();
	}

	override function update(frame:Frame)
	{
		root.tile = Tile.fromColor(0x1a1d22, game.window.width, game.window.height, .65);
		if (!game.console.isActive())
		{
			game.console.show();
		}
	}

	override function onKeyDown(key:KeyCode)
	{
		if (Keybinding.CONSOLE_SCREEN == key)
		{
			game.screens.pop();
		}
	}
}
