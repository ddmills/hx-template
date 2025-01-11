package data.resources;

import common.struct.DataRegistry;
import h2d.Font;

class FontRegistry extends DataRegistry<FontFamily, Font>
{
	public function new()
	{
		super();

		register(FNT_BIZCAT, hxd.Res.fnt.bizcat.toFont());
	}

	public function text(fnt:FontFamily, ?parent:h2d.Object)
	{
		var font = get(fnt);
		return new h2d.Text(font, parent);
	}
}
