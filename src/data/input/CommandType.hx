package data.input;

enum abstract CommandType(String) to String
{
	var CMD_SAVE = 'save';
	var CMD_CONFIRM = 'confirm';
	var CMD_CYCLE_INPUT = 'tab input';
	var CMD_CYCLE_INPUT_REVERSE = 'tab input (reverse)';
	var CMD_CANCEL = 'cancel';
	var CMD_CONSOLE = 'open console';
	var CMD_PAUSE = 'pause';
	var CMD_SPEED_1 = 'set speed 1';
	var CMD_SPEED_2 = 'set speed 2';
	var CMD_SPEED_3 = 'set speed 3';
	var CMD_SPEED_4 = 'set speed 4';
}
