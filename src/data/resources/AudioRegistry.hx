package data.resources;

import common.struct.DataRegistry;
import hxd.res.Sound;

class AudioRegistry extends DataRegistry<AudioKey, Sound>
{
	public function new()
	{
		super();

		if (hxd.res.Sound.supportedFormat(OggVorbis))
		{
			// register audio
		}
		else
		{
			trace('OggVorbis NOT SUPPORTED');
		}
	}
}
