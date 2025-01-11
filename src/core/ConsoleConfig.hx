package core;

import common.util.Serial;
import core.input.Command;
import data.core.Commands;
import h2d.Console;

class ConsoleConfig
{
	static var TEXT_COLOR = 0xffffff;
	static var game(get, never):Game;

	public static function Config(console:Console)
	{
		console.log('Type "help" for list of commands.');

		console.addCommand('exit', 'Close the console', [], () ->
		{
			game.screens.pop();
		});

		console.addCommand('cmds', 'List available commands on current screen', [], () ->
		{
			console.log('Available commands', TEXT_COLOR);
			Commands.GetForDomains([INPUT_DOMAIN_DEFAULT, game.screens.previous.inputDomain]).each((cmd:Command) ->
			{
				console.log('${cmd.friendlyKey()} - ${cmd.name}', TEXT_COLOR);
			});
		});

		console.addCommand('entity', 'Lookup entity', [{name: 'entityId', t: AString}], (id:String) ->
		{
			var entity = game.registry.getEntity(id);

			if (entity != null)
			{
				var s = entity.save();
				var json = Serial.Serialize(s);
				console.log(json);
			}
			else
			{
				console.log('Entity not found');
			}
		});

		console.addCommand('ecount', 'Entity Count', [], () -> entityCountCmd(console));
	}

	static function entityCountCmd(console:Console)
	{
		console.log('Entities: ${game.registry.size}', TEXT_COLOR);
	}

	static function get_game():Game
	{
		return Game.instance;
	}
}
