package hxlpers.colors;

/**
 * ...
 * @author damrem
 */
class ColorComponent
{

	static public inline var OPAQUE:UInt = 0xFF000000;
	
	static public inline var ALPHA_BITSHIFT:UInt = 24;
	static public inline var ALPHA_MASK:UInt = 0xFF000000;
	static public inline var ALPHA_NEGATIVE:UInt= 0x00FFFFFF;
	
	static public inline var RED_BITSHIFT:UInt = 16;
	static public inline var RED_MASK:UInt = 0xFF0000;
	static public inline var RED_NEGATIVE:UInt = 0x00FFFF;
	
	static public inline var GREEN_BITSHIFT:UInt = 8;
	static public inline var GREEN_MASK:UInt = 0x00FF00;
	static public inline var GREEN_NEGATIVE:UInt = 0xFF00FF;
	
	static public inline var BLUE_BITSHIFT:UInt = 0;
	static public inline var BLUE_MASK:UInt = 0x0000FF;
	static public inline var BLUE_NEGATIVE:UInt = 0xFFFF00;
	
	
	
}