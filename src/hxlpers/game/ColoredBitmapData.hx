package hxlpers.game;
import openfl.display.BitmapData;

/**
 * ...
 * @author damrem
 */
class ColoredBitmapData extends BitmapData
{
	public var fillColor:UInt;

	public function new(w:Float, h:Float, transparent:Bool=true, fillColor:UInt=0xFFFFFFFF) 
	{
		super(Math.ceil(w), Math.ceil(h), transparent, fillColor);
		this.fillColor = fillColor;
	}
	
	public function fill()
	{
		fillRect(rect, fillColor);
	}
	
}