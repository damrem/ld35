package hxlpers.shapes;

import flash.display.Shape;

/**
 * ...
 * @author damrem
 */
class BoxShape extends ShortcutShape
{
	var centered:Bool;

	public function new(Width:Float = 10.0, Height:Float = 10.0, FillColor:UInt = 0xff0000, Thickness:Float=0.0, StrokeColor:UInt=0x000000, Centered:Bool=true) 
	{
		super(FillColor, Thickness, StrokeColor);
		this.centered = Centered;
		graphics.drawRect(centered? -Width / 2:0, centered? -Height / 2:0, Width, Height);
		endFill();
	}
	
	
	
}