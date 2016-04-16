package hxlpers;

/**
 * ...
 * @author damrem
 */
class IntSF
{

	public static function toFixedLengthString(user:Int, length:Int, truncate:Bool=false):String 
	{
		//trace("toFixedLengthString", user, length, truncate);
		var s:String = Std.string(user);
		
		while (s.length < length)
		{
			s = "0" + s;
		}
		return s;
	}
	
}