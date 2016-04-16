package hxlpers.geom;
import flash.geom.Point;

/**
 * ...
 * @author damrem
 */
class V2d extends Point
{
	public function new(?X:Float, ?Y:Float)
	{
		super(X, Y);
	}
	
	public static function fromPoint(p:Point):V2d
	{
		return new V2d(p.x, p.y);
	}
	
	public static function fromPoints(p0:Point, p1:Point):V2d
	{
		return new V2d(p1.x - p0.x, p1.y - p0.y);
	}
	
	public function getAngle():Float
	{
		return Math.atan2(y, x);
	}
	
	
}