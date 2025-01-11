package domain.components;

import common.struct.FloatPoint;
import core.rendering.RenderLayerManager.RenderLayerType;
import ecs.Component;
import h2d.Graphics;
import shaders.SpriteShader;

abstract class Drawable extends Component
{
	@save public var layer(default, null):RenderLayerType;
	@save public var isVisible(default, set):Bool = true;
	@save public var width(get, set):Float;
	@save public var height(get, set):Float;
	@save public var origin(default, set):FloatPoint = new FloatPoint(.5, .5);

	public var ob(default, null):h2d.Object;
	public var shader(default, null):SpriteShader;
	public var drawable(get, never):h2d.Drawable;

	public var debug(default, set):Bool;

	private var debugGraphics:Graphics;

	public function new(layer = OBJECTS)
	{
		shader = new SpriteShader();

		this.layer = layer;
		this.ob = new h2d.Object();
	}

	abstract function getDrawable():h2d.Drawable;

	abstract function setWidth(v:Float):Float;

	abstract function setHeight(v:Float):Float;

	abstract function getWidth():Float;

	abstract function getHeight():Float;

	public function updatePos(px:Float, py:Float)
	{
		ob.x = px;
		ob.y = py;
	}

	inline function set_isVisible(value:Bool):Bool
	{
		isVisible = value;
		return drawable.visible = value;
	}

	override function onRemove()
	{
		drawable.remove();
	}

	inline function get_drawable():h2d.Drawable
	{
		return getDrawable();
	}

	inline function get_width():Float
	{
		return getWidth();
	}

	inline function get_height():Float
	{
		return getHeight();
	}

	inline function set_width(value:Float):Float
	{
		return setWidth(value);
	}

	inline function set_height(value:Float):Float
	{
		return setHeight(value);
	}

	inline function set_origin(value:FloatPoint):FloatPoint
	{
		origin = value;
		recomputeOrigin();
		return value;
	}

	function recomputeOrigin()
	{
		if (drawable != null)
		{
			drawable.x = origin.x * -getWidth();
			drawable.y = origin.y * -getHeight();
		}
	}

	function set_debug(value:Bool):Bool
	{
		if (value)
		{
			var b = drawable.getBounds(ob);

			debugGraphics = new Graphics(ob);
			debugGraphics.lineStyle(2, 0xFF00FF, .1);
			debugGraphics.drawRect(drawable.x, drawable.y, b.width, b.height);
			debugGraphics.beginFill(0xFF7300, 1);
			debugGraphics.lineStyle(2, 0xFF00FF, 0);
			debugGraphics.drawCircle(0, 0, 3);
		}
		else
		{
			debugGraphics.remove();
			debugGraphics = null;
		}

		return debug = value;
	}
}
