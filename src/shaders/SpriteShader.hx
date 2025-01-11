package shaders;

import core.Game;
import data.core.ColorKey;

class SpriteShader extends hxsl.Shader
{
	static var SRC =
		{
			var pixelColor:Vec4;
			@global var time:Float;
			function fragment()
			{
				var color = pixelColor.rgb;
			}
		};
}
