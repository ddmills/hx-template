package data;

import data.domain.PrefabRegistry;
import data.resources.AnimationRegistry;
import data.resources.AudioRegistry;
import data.resources.FontRegistry;
import data.resources.TileRegistry;

class Data
{
	public static var Tiles(default, null):TileRegistry;
	public static var Animations(default, null):AnimationRegistry;
	public static var Prefabs(default, null):PrefabRegistry;
	public static var Audio(default, null):AudioRegistry;
	public static var Fonts(default, null):FontRegistry;

	public static function Init()
	{
		Tiles = new TileRegistry();
		Animations = new AnimationRegistry();
		Audio = new AudioRegistry();
		Prefabs = new PrefabRegistry();
		Fonts = new FontRegistry();
	}
}
