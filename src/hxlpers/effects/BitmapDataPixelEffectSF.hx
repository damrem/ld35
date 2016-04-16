package hxlpers.effects;
import openfl.display.BitmapData;
import openfl.utils.ByteArray;

/**
 * ...
 * @author damrem
 */
class BitmapDataPixelEffectSF
{

	static public function pixelEffect(user:BitmapData, pixelSize:UInt) 
	{
		var pixels:ByteArray = user.getPixels(user.rect);
		
		pixels.position = 0;
		//trace(pixels.position, pixels.length);
		
		while (pixels.position < pixels.length)
		{
			if (pixels.position % pixelSize == 0 && Std.int(pixels.position / pixelSize) % pixelSize == 0)
			{
				//pixels.writeUnsignedInt(0xffff00);
				pixels.position+=4;
			}
			else
			{
				pixels.position+=4;
			}
			//trace(pixels.position);
		}
		//user.setPixels(user.rect, pixels);
	}
	
}