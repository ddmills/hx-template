package screens.loading;

import core.Frame;
import core.Screen;
import core.input.KeyCode;
import data.Data;
import data.core.ColorKey;
import domain.World;
import screens.play.PlayScreen;

class LoadingScreen extends Screen
{
	var text:h2d.Text;

	public function new() {}

	public override function onEnter()
	{
		game.mount();

		text = Data.Fonts.text(FNT_BIZCAT);
		text.text = "Press N for new game, L to load game.";
		text.color = ColorKey.C_YELLOW.toHxdColor();

		game.render(HUD, text);
	}

	override function onDestroy()
	{
		text.remove();
	}

	override function update(frame:Frame)
	{
		text.textAlign = Center;
		text.x = camera.width / 2;
		text.y = camera.height / 2;
	}

	override function onKeyDown(key:KeyCode)
	{
		if (key == KEY_N)
		{
			var seed = Std.random(0xffffff);
			trace('seed - ${seed}');
			game.files.deleteSave('test');
			game.files.setSaveName('test');
			game.setWorld(new World());
			game.world.initialize();
			game.world.newGame(seed);
			start();
		}
		if (key == KEY_L)
		{
			game.files.setSaveName('test');
			var data = game.files.tryReadWorld();
			game.setWorld(new World());
			game.world.initialize();
			game.world.load(data);
			start();
		}
	}

	private function start()
	{
		game.screens.set(new PlayScreen());
	}
}
