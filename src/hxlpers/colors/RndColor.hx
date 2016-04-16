package hxlpers.colors;



/**
 * ...
 * @author damrem
 */
class RndColor
{
	static public function XX(min:Float = 0, max:Float = 1, bitShift:UInt=0):Int
	{
		var minComp = Std.int(min * 0xFF);
		var maxComp = Std.int(max * 0xFF);
		return Random.int(minComp, maxComp) << bitShift;
	}
	
	static public function alpha(min:Float=0,max:Float=1):Int
	{
		return XX(min, max, ColorComponent.ALPHA_BITSHIFT);
	}
	
	static public function red(min:Float=0,max:Float=1):Int
	{
		return XX(min, max, ColorComponent.RED_BITSHIFT);
	}
	
	static public function green(min:Float=0,max:Float=1):Int
	{
		return XX(min, max, ColorComponent.GREEN_BITSHIFT);
	}
	
	static public function blue(min:Float=0,max:Float=1):Int
	{
		return XX(min, max, ColorComponent.BLUE_BITSHIFT);
	}
	
	static public function rgb(min:Float=0,max:Float=1):UInt
	{
		return red(min, max) + green(min, max) + blue(min, max);
	}
	
	static public function argb(min:Float=0,max:Float=1):UInt
	{
		return alpha(min, max) + rgb(min, max);
	}
	
	static public function gray(min:Float = 0, max:Float = 1):UInt
	{
		var comp = XX(min, max);
		return (comp << ColorComponent.RED_BITSHIFT) + (comp << ColorComponent.GREEN_BITSHIFT) + (comp << ColorComponent.BLUE_BITSHIFT);
	}
	
}