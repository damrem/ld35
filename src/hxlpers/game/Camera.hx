package hxlpers.game;
import hxlpers.game.Room;
import hxlpers.geom.Dim;
import hxlpers.geom.Pos;
import openfl.display.Bitmap;
import openfl.display.BitmapData;
import openfl.geom.Matrix;
import openfl.geom.Point;
import openfl.geom.Rectangle;

using hxlpers.display.BitmapDataSF;
using hxlpers.display.DisplayObjectSF;

/**
 * ...
 * @author damrem
 */
class Camera
{

	public var screen:BitmapData;
	public var rect(get, null):Rectangle;
	public var pos:Pos;
	var dim:Dim;
	
	var room:Room;
	public var zoomLevel:Float=1;	
	public var initialPos(get, null):Pos;
	private var _initialPos:Pos;
	function get_initialPos():Pos { return _initialPos; }
	var followed:Dynamic;
	
	public function new(room:Room, pos:Pos, dim:Dim) 
	{
		this.room = room;
		trace(dim);
		this.dim = dim;
		this.pos = _initialPos = pos;
		
		screen = new BitmapData(Math.ceil(dim.w), Math.ceil(dim.h));
	}
	
	function setRoom(room:Room)
	{
		this.room = room;
	}
	
	public function follow(object:Dynamic)
	{
		followed = object;
	}
	
	public function update()
	{
		if (followed != null)
		{
			pos.x = followed.x;
			pos.y = followed.y;
		}
		
		
	}
	
	public function render(layerList:LayerList) 
	{
		screen.clear(0xff000000);
		for (layer in layerList.getLayers())
		{
			if (layer.isVisible)
			{
				screen.draw(layer/*, new Matrix(zoomLevel, 0, 0, zoomLevel, screen.width/2-pos.x, 0)*/);//FIXME the last 0 should be -rect.y, but it shifts incoherently
			}
		}
	}
	
	function get_rect():Rectangle 
	{
		var focusedDim:Dim = { w:dim.w / zoomLevel, h:dim.h / zoomLevel };
		return new Rectangle(pos.x - focusedDim.w / 2, pos.y - focusedDim.h / 2, focusedDim.w, focusedDim.h);
	}
	
	
}

