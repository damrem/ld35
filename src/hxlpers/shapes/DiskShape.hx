package hxlpers.shapes;

import hxlpers.shapes.ShortcutShape;


/**
 * ...
 * @author damrem
 */
class DiskShape extends ShortcutShape
{

	public function new(Radius:Float, FillColor:UInt = 0xff0000, Thickness:Float=0.0, StrokeColor:UInt=0x000000) 
	{
		super(FillColor, Thickness, StrokeColor);
		if (Thickness > 0)
		{
			graphics.lineStyle(Thickness, StrokeColor);
		}
		graphics.beginFill(FillColor);
		graphics.drawCircle(0, 0, Radius);
		endFill();
	}
	
}