package hxlpers.geom ;
import openfl.geom.Point;

/**
 * ...
 * @author damrem
 */
class Pt 
{
	static public function centroid(points:Array<Point>):Point
	{
		var c = new Point();
		for (p in points)
		{
			c=c.add(p);
		}
		c.normalize(c.length / points.length);
		return c;
	}
	
}