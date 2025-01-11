package data.core;

import core.input.Command;
import core.input.KeyCode;
import data.input.CommandType;
import data.input.InputDomainType;

class Commands
{
	public static var values:Array<Command>;

	public static function Init()
	{
		values = new Array();
		// @formatter:off
		//  Domain                    Type                     Key            Shift   Ctrl   Alt
		cmd(INPUT_DOMAIN_DEFAULT,     CMD_CONSOLE,             KEY_COMMA);
		cmd(INPUT_DOMAIN_DEFAULT,     CMD_CYCLE_INPUT,         KEY_TAB);
		cmd(INPUT_DOMAIN_DEFAULT,     CMD_CYCLE_INPUT_REVERSE, KEY_TAB,       true);
		cmd(INPUT_DOMAIN_DEFAULT,     CMD_SAVE,                KEY_S,         false,   true);
		cmd(INPUT_DOMAIN_DEFAULT,     CMD_CONFIRM,             KEY_ENTER);
		cmd(INPUT_DOMAIN_DEFAULT,     CMD_CANCEL,              KEY_ESCAPE);
		cmd(INPUT_DOMAIN_PLAY,        CMD_PAUSE,               KEY_SPACE);
		cmd(INPUT_DOMAIN_PLAY,        CMD_SPEED_1,             KEY_F1);
		cmd(INPUT_DOMAIN_PLAY,        CMD_SPEED_2,             KEY_F2);
		cmd(INPUT_DOMAIN_PLAY,        CMD_SPEED_3,             KEY_F3);
		cmd(INPUT_DOMAIN_PLAY,        CMD_SPEED_4,             KEY_F4);
		// @formatter:on
	}

	public static function GetForDomains(domains:Array<InputDomainType>):Array<Command>
	{
		return values.filter((c) -> domains.has(c.domain));
	}

	private static function cmd(domain:InputDomainType, type:CommandType, key:KeyCode, shift:Bool = false, ctrl:Bool = false, alt:Bool = false)
	{
		values.push({
			domain: domain,
			type: type,
			key: key,
			shift: shift,
			ctrl: ctrl,
			alt: alt,
		});
	}
}
