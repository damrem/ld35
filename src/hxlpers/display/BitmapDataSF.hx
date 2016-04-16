package hxlpers.display;
import hxlpers.colors.ColorComponent;
import hxlpers.colors.ARGBColor;
import hxlpers.colors.RndColor;
import openfl.display.Bitmap;
import openfl.display.BitmapData;
import openfl.geom.Matrix;
import openfl.geom.Rectangle;
import openfl.utils.ByteArray;

using hxlpers.display.BitmapDataSF;

/**
 * ...
 * @author damrem
 */
class BitmapDataSF
{

	static public function getAllPixels(user:BitmapData):ByteArray
	{
		return user.getPixels(user.rect);
	}
	
	static public function clear(user:BitmapData, color:ARGBColor=0):BitmapData
	{
		user.fillRect(new Rectangle(0, 0, cast(user.width), cast(user.height)), color);
		return user;
	}
	
	static public function simpleNoise(dt:BitmapData, density:Float=1, monochromatic:Bool=true, transparent:Bool=true):BitmapData
	{
		var w:UInt = cast(dt.width);
		var h:UInt = cast(dt.height);
		var pixels:ByteArray = new ByteArray();
		if (monochromatic && !transparent)
		{
			for (i in 0...w*h)
			{
				if (Rnd.chance(density))
				{
					pixels.writeUnsignedInt(ColorComponent.OPAQUE + RndColor.gray());
				}
				else
				{
					pixels.writeUnsignedInt(0);
				}
			}
		}
		else if(!monochromatic && transparent)
		{
			for (i in 0...w*h)
			{
				if (Rnd.chance(density))
				{
					pixels.writeUnsignedInt(RndColor.alpha() + RndColor.rgb());
				}
				else
				{
					pixels.writeUnsignedInt(0);
				}
			}
		}
		else if(monochromatic && transparent)
		{
			for (i in 0...w*h)
			{
				if (Rnd.chance(density))
				{
					pixels.writeUnsignedInt(RndColor.alpha() + RndColor.gray());
				}
				else
				{
					pixels.writeUnsignedInt(0);
				}
			}
		}
		else if(!monochromatic && !transparent)
		{
			for (i in 0...w*h)
			{
				if (Rnd.chance(density))
				{
					pixels.writeUnsignedInt(ColorComponent.OPAQUE + RndColor.rgb());
				}
				else
				{
					pixels.writeUnsignedInt(0);
				}
			}
		}
		
		pixels.position = 0;
		var zone = new Rectangle(0, 0, w, h);
		dt.setPixels(zone, pixels);
		return dt;
	}
	
	
	
	/**
	 * http://stackoverflow.com/questions/7773488/flipping-a-bitmap-horizontally
	 * @param	user:BitmapData
	 * @return	the bitmapData for chaining
	 */
	static public function flipX(user:BitmapData):BitmapData
	{
		var flipped:BitmapData = new BitmapData(user.width, user.height, true, 0);
		flipped.draw(user, new Matrix( -1, 0, 0, 1, user.width, 0), null, null, null, true);
		user.clear();
		user.draw(flipped);
		return user;
	}
	
	static public function flipY(user:BitmapData):BitmapData
	{
		var flipped:BitmapData = new BitmapData(user.width, user.height, true, 0);
		flipped.draw(user, new Matrix( 1, 0, 0, -1, 0, user.height), null, null, null, true);
		user.clear();
		user.draw(flipped);
		return user;
	}
	
}