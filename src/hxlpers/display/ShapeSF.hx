package hxlpers.display;
import openfl.display.Shape;
using hxlpers.display.GraphicsSF;
/**
 * ...
 * @author damrem
 */
class ShapeSF
{

	static public function rect(user:Shape, w:Float, h:Float, fillColor:UInt=0xffffff, borderThickness:Float=0, borderColor:UInt=0x000000, centered:Bool=false):Shape
	{
		user.graphics.rect(w, h, fillColor, borderThickness, borderColor, centered);
		return user;
	}
	
	static public function circle(user:Shape, radius:Float, fillColor:UInt=0xffffff, borderThickness:Float=0, borderColor:UInt=0x000000):Shape
	{
		user.graphics.circle(radius, fillColor, borderThickness, borderColor);
		return user;
	}
	
	static public function ellipse(user:Shape, hRadius:Float, vRadius:Float, fillColor:UInt=0xffffff, borderThickness:Float=0, borderColor:UInt=0x000000):Shape
	{
		user.graphics.ellipse(hRadius, vRadius, fillColor, borderThickness, borderColor);
		return user;
	}
	
	
	
}