package core;

import data.Data;
import data.resources.AudioKey;

class AudioManager
{
	public function new()
	{
		var manager = hxd.snd.Manager.get();
		manager.masterVolume = 0.25;
	}

	public function play(key:Null<AudioKey>)
	{
		var sound = Data.Audio.get(key);

		if (sound.isNull())
		{
			return;
		}

		sound.play();
	}
}
