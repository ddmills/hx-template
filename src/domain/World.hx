package domain;

import common.tools.Performance;
import core.Game;
import data.input.InputGroups;
import domain.Clock.SaveClock;
import hxd.Rand;

typedef SaveWorld =
{
	public var seed:Int;
	public var clock:SaveClock;
}

class World
{
	public var game(get, null):Game;
	public var clock(default, null):Clock;
	public var systems(default, null):SystemManager;
	public var seed:Int = 2;
	public var rand:Rand;
	public var input:InputGroups;

	public function new()
	{
		clock = new Clock();
		systems = new SystemManager();
		input = new InputGroups();
	}

	public function initialize()
	{
		rand = new Rand(seed);
		systems.initialize();
	}

	public function updateSystems()
	{
		clock.update(game.frame);
		systems.update(game.frame);
	}

	public function newGame(seed:Int)
	{
		this.seed = seed;
		rand = new Rand(seed);
	}

	public function load(data:SaveWorld)
	{
		Performance.start('world-load');
		seed = data.seed;
		rand = new Rand(seed);
		clock.load(data.clock);

		Performance.stop('world-load', true);
	}

	public function save(teardown:Bool = false):SaveWorld
	{
		Performance.start('world-save');

		var s = {
			seed: seed,
			clock: clock.save(),
		};

		Performance.stop('world-save', true);

		return s;
	}

	inline function get_game():Game
	{
		return Game.instance;
	}
}
