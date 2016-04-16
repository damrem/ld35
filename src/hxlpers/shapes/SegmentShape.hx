package hxlpers.shapes;
import openfl.display.Shape;
import openfl.geom.Point;

/**
 * ...
 * @author damrem
 */
class SegmentShape extends Shape
{
	var point1:Point;
	var point2:Point;
	public function new(Point1:Point, Point2:Point) 
	{
		super();
		//trace(Point1, Point2);
		point1 = Point1;
		point2 = Point2;
		
		draw();
	}
	
	public function draw() 
	{
		//graphics.clear();
		graphics.moveTo(point1.x, point1.y);
		graphics.lineTo(point2.x, point2.y);
	}
	
	
}