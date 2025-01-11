package data.domain;

import common.struct.Coordinate;
import common.struct.DataRegistry;
import common.struct.IntPoint;
import core.Game;

class PrefabRegistry extends DataRegistry<PrefabType, Prefab>
{
	public function new()
	{
		super();
	}

	public function spawn(type:PrefabType, ?pos:Coordinate, ?options:Dynamic)
	{
		var p = pos == null ? new Coordinate(0, 0, WORLD) : pos.toWorld().floor();

		var o = options == null ? {} : options;
		var entity = Data.Prefabs.get(type).Create(o, p);

		entity.pos = p;

		return entity;
	}
}
