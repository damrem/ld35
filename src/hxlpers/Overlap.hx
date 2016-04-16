package hxlpers;
import flash.geom.Rectangle;

/**
 * ...
 * @author ...
 */
class Overlap
{
	public static function ranges(range1:Range, range2:Range):Bool
	{
		if (range1.max < range2.min || range2.max < range1.min)
		{
			return false;
		}
		return true;
	}
	
	public static function rectangles(rect1:Rectangle, rect2:Rectangle):Bool
	{
		var xRange1 = new Range(rect1.x, rect1.x + rect1.width);
		var xRange2 = new Range(rect2.x, rect2.x + rect2.width);
		
		var yRange1 = new Range(rect1.y, rect1.y + rect1.height);
		var yRange2 = new Range(rect2.y, rect2.y + rect2.height);
		
		return ranges(xRange1, xRange2) && ranges(yRange1, yRange2);
	}
	
}