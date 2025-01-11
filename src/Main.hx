import core.Game;
import data.Data;
import data.core.Commands;
import screens.splash.SplashScreen;

class Main extends hxd.App
{
	var game:Game;

	static function main()
	{
		hxd.Res.initEmbed();
		new Main();
	}

	override function init()
	{
		// hack to fix audio not playing more than once
		@:privateAccess haxe.MainLoop.add(() -> {});

		Commands.Init();
		Data.Init();

		var window = hxd.Window.getInstance();

		window.title = "Privateers";

		game = Game.Create(this);
		game.backgroundColor = game.CLEAR_COLOR;
		game.screens.set(new SplashScreen(10));
	}

	override function update(dt:Float)
	{
		game.update();
	}
}
