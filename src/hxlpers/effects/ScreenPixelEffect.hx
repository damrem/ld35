package hxlpers.effects;
import openfl.Assets;
import openfl.display.Bitmap;
import openfl.display.BitmapData;
import openfl.display.Shape;
import openfl.display.Sprite;

/**
 * ...
 * @author damrem
 */
class ScreenPixelEffect extends Bitmap
{

	public function new(w:UInt, h:UInt, pixel:BitmapData) 
	{
		var canvas = new Shape();
		canvas.graphics.beginBitmapFill(pixel);
		canvas.graphics.drawRect(0, 0, w, h);
		canvas.graphics.endFill();
		var effectBuffer = new BitmapData(w, h, true, 0x00000000);
		effectBuffer.draw(canvas);
		super(effectBuffer);
	}
	
}