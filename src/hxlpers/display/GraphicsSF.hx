package hxlpers.display;
import hxlpers.colors.ARGBColor;
import openfl.display.Graphics;

/**
 * ...
 * @author damrem
 */
class GraphicsSF
{

	static public function rect(user:Graphics, w:Float, h:Float, fillColor:UInt=0xffffff, borderThickness:Float=0, borderColor:UInt=0x000000, centered:Bool=false):Graphics 
	{
		if (borderThickness > 0)
		{
			user.lineStyle(borderThickness, borderColor);
		}
		user.beginFill(fillColor);
		user.drawRect(centered? -w / 2:0, centered? -h / 2:0, w, h);
		user.endFill();
		return user;
	}
	
	static public function circle(user:Graphics, radius:Float, fillColor:UInt=0xffffff, borderThickness:Float=0, borderColor:UInt=0x000000):Graphics 
	{
		if (borderThickness > 0)
		{
			user.lineStyle(borderThickness, borderColor);
		}
		user.beginFill(fillColor);
		user.drawCircle(0, 0, radius);
		user.endFill();
		return user;
	}
	
	static public function ellipse(user:Graphics, hRadius:Float, vRadius:Float, fillColor:UInt=0xffffff, borderThickness:Float=0, borderColor:UInt=0x000000):Graphics 
	{
		if (borderThickness > 0)
		{
			user.lineStyle(borderThickness, borderColor);
		}
		user.beginFill(fillColor);
		user.drawEllipse(0, 0, hRadius, vRadius);
		user.endFill();
		return user;
	}
	
}