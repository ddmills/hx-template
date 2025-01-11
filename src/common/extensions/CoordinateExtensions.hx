package common.extensions;

import common.algorithm.Distance;
import common.struct.Cardinal;
import common.struct.Coordinate;
import common.struct.FloatPoint;
import common.util.Easing.EasingType;
import common.util.Easing;
import common.util.Projection;
import core.Game;

class CoordinateExtensions
{
	static public inline function toString(c:Coordinate, precision:Int = null):String
	{
		return switch c.space
		{
			case SCREEN: 'S(${c.x},${c.y})';
			case PIXEL: 'P(${c.x},${c.y})';
			case WORLD: 'W(${c.x},${c.y})';
		}
	}

	static public inline function floor(c:Coordinate):Coordinate
	{
		return new Coordinate(c.x.floor(), c.y.floor(), c.space);
	}

	static public inline function round(c:Coordinate):Coordinate
	{
		return new Coordinate(c.x.round(), c.y.round(), c.space);
	}

	static public inline function ciel(c:Coordinate):Coordinate
	{
		return new Coordinate(c.x.ciel(), c.y.ciel(), c.space);
	}

	static public inline function toSpace(c:Coordinate, space:Space):Coordinate
	{
		var px = c.toPx();

		return switch space
		{
			case PIXEL: px;
			case SCREEN: Projection.pxToScreen(px.x, px.y);
			case WORLD: Projection.pxToWorld(px.x, px.y);
		}
	}

	static public inline function toWorld(c:Coordinate):Coordinate
	{
		return switch c.space
		{
			case PIXEL: Projection.pxToWorld(c.x, c.y);
			case SCREEN: Projection.screenToWorld(c.x, c.y);
			case WORLD: c;
		}
	}

	static public inline function toPx(c:Coordinate):Coordinate
	{
		return switch c.space
		{
			case PIXEL: c;
			case SCREEN: Projection.screenToPx(c.x, c.y);
			case WORLD: Projection.worldToPx(c.x, c.y);
		}
	}

	static public inline function toScreen(c:Coordinate):Coordinate
	{
		return switch c.space
		{
			case PIXEL: Projection.pxToScreen(c.x, c.y);
			case SCREEN: c;
			case WORLD: Projection.worldToScreen(c.x, c.y);
		}
	}

	static public inline function lerp(a:Coordinate, b:Coordinate, time:Float):Coordinate
	{
		var projected = b.toSpace(a.space);

		return new Coordinate(a.x.lerp(projected.x, time), a.y.lerp(projected.y, time), a.space);
	}

	static public inline function sub(a:Coordinate, b:Coordinate):Coordinate
	{
		var projected = b.toSpace(a.space);

		return new Coordinate(a.x - projected.x, a.y - projected.y, a.space);
	}

	static public inline function add(a:Coordinate, b:Coordinate):Coordinate
	{
		var projected = b.toSpace(a.space);

		return new Coordinate(a.x + projected.x, a.y + projected.y, a.space);
	}

	static public inline function manhattan(a:Coordinate, b:Coordinate):Float
	{
		var projected = b.toSpace(a.space);

		return (a.x - projected.x).abs() + (a.y - projected.y).abs();
	}

	static public inline function distance(a:Coordinate, b:Coordinate, space:Space = WORLD, formula:DistanceFormula = EUCLIDEAN):Float
	{
		var pa = a.toSpace(space).toFloatPoint();
		var pb = b.toSpace(space).toFloatPoint();
		return Distance.Get(pa, pb, formula);
	}

	static public inline function radians(a:Coordinate):Float
	{
		var rad = Math.atan2(a.y, a.x);
		return rad < 0 ? Math.PI * 2 + rad : rad;
	}

	static public inline function degrees(a:Coordinate):Float
	{
		return radians(a).toDegrees();
	}

	static public inline function radiansBetween(a:Coordinate, b:Coordinate):Float
	{
		return b.sub(a).radians();
	}

	static public inline function degreesBetween(a:Coordinate, b:Coordinate):Float
	{
		return b.sub(a).degrees();
	}

	static public inline function cardinal(a:Coordinate):Cardinal
	{
		return Cardinal.fromRadians(radians(a));
	}

	public static inline function lengthSq(a:Coordinate):Float
	{
		return a.x * a.x + a.y * a.y;
	}

	/**
	 * Returns length (distance to `0,0`) of this Coordinate.
	**/
	public inline function length(a:Coordinate):Float
	{
		return Math.sqrt(lengthSq(a));
	}

	static public inline function normalized(a:Coordinate):FloatPoint
	{
		var k = lengthSq(a);
		if (k < hxd.Math.EPSILON)
		{
			k = 0;
		}
		else
		{
			k = hxd.Math.invSqrt(k);
		}

		return {
			x: a.x * k,
			y: a.y * k,
		};
	}

	static public inline function equals(a:Coordinate, b:Coordinate):Bool
	{
		return a.space == b.space && a.x == b.x && a.y == b.y;
	}

	/**
	 * Returns normalized vector from a to b
	**/
	static public inline function direction(a:Coordinate, b:Coordinate):FloatPoint
	{
		return b.sub(a).normalized();
	}

	/**
	 * Returns Coordinate eased from a to b
	**/
	static public inline function ease(a:Coordinate, b:Coordinate, x:Float, easing:EasingType):Coordinate
	{
		var progress = Easing.apply(x, easing);
		var direction = a.direction(b);
		var distance = a.toWorld().distance(b.toWorld(), EUCLIDEAN);

		var newPx = direction.multiply(progress * distance);

		return newPx.asWorld().add(a);
	}

	/**
	 * Returns Coordinate eased from a to b
	**/
	static public inline function easeZig(a:Coordinate, b:Coordinate, x:Float, easing:EasingType):Coordinate
	{
		var progress = Easing.applyZig(x, easing);
		var direction = a.direction(b);
		var distance = a.toWorld().distance(b.toWorld(), EUCLIDEAN);

		var newPx = direction.multiply(progress * distance);

		return newPx.asWorld().add(a);
	}
}
