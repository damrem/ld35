package hxlpers.colors;

/**
 * ...
 * @author damrem
 */
class ColorSF
{
	//TODO abstract Color(UInt) or Color({a,r,g,b})
	static public function hexa(c:UInt):String
	{
		var bb = c & 0x0000ff>>0;
		var gg = c & 0x00ff00>>8;
		var rr = c & 0xff0000>>16;
		return c+"("+rr + "," + gg + "," + bb+")";
	}
	
}