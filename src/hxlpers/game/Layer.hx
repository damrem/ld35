package hxlpers.game;
import openfl.display.Bitmap;
import openfl.display.BitmapData;
import openfl.display.Sprite;
import openfl.utils.ByteArray;

/**
 * ...
 * @author damrem
 */
class Layer extends Sprite
{
	var bmp:Bitmap;

	public var scrollRatio:ScrollRatio;
	public var isMouseInteractive:Bool;
	public var isVisible:Bool;
	public var data:ColoredBitmapData;
	
	public function new(bitmapData:ColoredBitmapData, mouseInteractive:Bool=false, isVisible:Bool=true) 
	{
		super();
		this.data = bitmapData;
		this.isVisible = isVisible;
		this.isMouseInteractive = mouseInteractive;
		scrollRatio = {x:1, y:1};
	}
	
	public function getBitmap():Bitmap
	{
		if (bmp == null)
		{
			bmp = new Bitmap(data);
		}
		return bmp;
	}
	
	public function render():BitmapData
	{
		data.fill();
		data.draw(this);
		return data;
	}
	
	public function getBytes(rerender:Bool=false):ByteArray
	{
		if (rerender)
		{
			render();
		}
		var _buffer = data.getPixels(data.rect);
		_buffer.position = 0;
		return _buffer;
	}
	
}

typedef ScrollRatio = {
	var x:Float;
	var y:Float;
}