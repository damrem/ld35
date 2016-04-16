package hxlpers.display;
import openfl.display.Sprite;
using hxlpers.display.GraphicsSF;
/**
 * ...
 * @author damrem
 */
class SpriteSF
{

	static public function rect(user:Sprite, w:Float, h:Float, fillColor:UInt=0xffffff, borderThickness:Float=0, borderColor:UInt=0x000000, centered:Bool=false):Sprite
	{
		user.graphics.rect(w, h, fillColor, borderThickness, borderColor, centered);
		return user;
	}
	
}