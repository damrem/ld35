package hxlpers.shapes;

import openfl.display.Shape;

/**
 * ...
 * @author damrem
 */
class ShortcutShape extends Shape
{

	public function new(FillColor:UInt = 0xff0000, Thickness:Float=0.0, StrokeColor:UInt=0x000000) 
	{
		super();
		if (Thickness > 0)
		{
			graphics.lineStyle(Thickness, StrokeColor);
		}
		graphics.beginFill(FillColor);
	}
	
	function endFill()
	{
		graphics.endFill();
		
	
	}
	
}