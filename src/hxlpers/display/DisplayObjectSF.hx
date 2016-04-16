package hxlpers.display;
import hxlpers.colors.ColorComponent;
import hxlpers.colors.ARGBColor;
import openfl.display.DisplayObject;
import openfl.geom.ColorTransform;
using hxlpers.display.GraphicsSF;

/**
 * ...
 * @author damrem
 */
class DisplayObjectSF
{
	static public function scale(user:DisplayObject, factor:Float=1.0):Float
	{
		return user.scaleX = user.scaleY = factor;
	}
	
	static public function color(user:DisplayObject, color:ARGBColor):DisplayObject
	{
		var ct = new ColorTransform();
		ct.color = color;
		user.transform.colorTransform = ct;
		return user;
	}
}