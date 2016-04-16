package hxlpers.shapes;
import hxlpers.geom.Pt;
import hxlpers.geom.V2d;
import openfl.display.Shape;
import openfl.geom.Point;

/**
 * ...
 * @author damrem
 */
class PolygonShape extends Shape
{
	var _vertices:Array<Point>;
	
	public function new(vertices:Array<Point>, ?center:Point) 
	{
		super();
		trace(vertices);
		_vertices = vertices;
		
		if (center == null)
		{
			center = Pt.centroid(_vertices);
		}
		
		trace('before ' + _vertices);
		for (vertex in _vertices)
		{
			trace(vertex + '->' + V2d.fromPoints(vertex, center).getAngle());
		}
		
		PolygonShape.orderPoints(_vertices, center);
		trace('after ' + _vertices);
		for (vertex in _vertices)
		{
			trace(vertex + '->' + V2d.fromPoints(vertex, center).getAngle());
		}
	}
	
	public function draw()
	{
		trace('draw');
		//graphics.clear();
		graphics.moveTo(_vertices[0].x, _vertices[0].y);
		for (i in 1..._vertices.length)
		{
			trace(_vertices[i]);
			graphics.lineTo(_vertices[i].x, _vertices[i].y);
		}
		graphics.lineTo(_vertices[0].x, _vertices[0].y);
	}
	
	public static function orderPoints(Points:Array<Point>, center)
	{
		Points.sort(
			function(p0:Point, p1:Point):Int
			{
				var a0 = V2d.fromPoints(p0, center).getAngle();
				var a1 = V2d.fromPoints(p1, center).getAngle();
				if (a0 > a1)
				{
					return 1;
				}
				else if (a1 > a0)
				{
					return -1;
				}
				return 0;
			}
		);
		
	
	}
	
}