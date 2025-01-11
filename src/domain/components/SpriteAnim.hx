package domain.components;

import core.Game;
import core.rendering.RenderLayerManager.RenderLayerType;
import data.resources.AnimationKey;
import data.resources.AnimationResources;
import domain.events.GameSpeedChange;
import h2d.Anim;
import h2d.Tile;

class SpriteAnim extends Drawable
{
	@save private var _speed:Float = 1;

	@save public var animationKey(default, set):AnimationKey;
	@save public var speed(get, set):Float;
	@save public var loop(default, set):Bool;
	@save public var destroyOnComplete:Bool;

	public var anim(default, null):Anim;
	public var tiles(get, never):Array<Tile>;

	public function new(animationKey:AnimationKey, speed:Float = 15, layer = OBJECTS, loop = true)
	{
		this.animationKey = animationKey;
		this.loop = loop;
		this.destroyOnComplete = false;
		this.speed = speed;

		super(layer);

		anim = new Anim(tiles, speed, ob);
		anim.loop = loop;
		anim.onAnimEnd = onAnimEnd;
		anim.speed = _speed * Game.instance.clock.speed;
		addHandler(GameSpeedChange, onGameSpeedChange);
	}

	private function onAnimEnd()
	{
		if (!loop)
		{
			anim.visible = false;
		}
		if (destroyOnComplete)
		{
			entity.add(new IsDestroyed());
		}
	}

	public function getAnimClone():Anim
	{
		var bm = new Anim(tiles, speed);
		return bm;
	}

	private function onGameSpeedChange(evt:GameSpeedChange)
	{
		if (anim != null)
		{
			anim.speed = _speed * evt.speed;
		}
	}

	function get_tiles():Array<Tile>
	{
		return AnimationResources.Get(animationKey);
	}

	public function set_animationKey(value:AnimationKey):AnimationKey
	{
		animationKey = value;
		if (anim != null)
		{
			var old = anim;
			anim = new Anim(tiles, speed, old.parent);
			anim.loop = loop;
			anim.x = old.x;
			anim.y = old.y;
			anim.visible = isVisible;
			width = tiles[0].width;
			height = tiles[0].height;
			old.remove();
		}
		return value;
	}

	function set_speed(value:Float):Float
	{
		_speed = value;
		if (anim != null)
		{
			anim.speed = _speed * Game.instance.clock.speed;
		}
		return value;
	}

	inline function getDrawable():h2d.Drawable
	{
		return anim;
	}

	function set_loop(value:Bool):Bool
	{
		loop = value;
		if (anim != null)
		{
			anim.loop = value;
		}
		return value;
	}

	inline function setWidth(value:Float):Float
	{
		var actual = (width / anim.scaleX);
		anim.scaleX = value / actual;
		recomputeOrigin();
		return value;
	}

	inline function setHeight(value:Float):Float
	{
		var actual = (height / anim.scaleY);
		anim.scaleY = value / actual;
		recomputeOrigin();
		return value;
	}

	inline function getWidth():Float
	{
		return anim.getBounds(ob).width;
	}

	inline function getHeight():Float
	{
		return anim.getBounds(ob).height;
	}

	function get_speed():Float
	{
		return _speed;
	}
}
