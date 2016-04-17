package;
import msignal.Signal.AnySignal;
import msignal.Signal.Signal1;
import openfl.Assets;
import openfl.display.Bitmap;
import openfl.display.Sprite;
import openfl.text.TextField;

/**
 * ...
 * @author damrem
 */
class ResourceIndicator extends Sprite
{

	public var txt:TextField;
	
	public function new(img:String, ?initValue:Int) 
	{
		super();
		txt = new Txt(""+initValue, Main.ftHuge);
		addChild(txt);
		txt.y = 8;
		//txt.text = ""+Main.vampireShip.crew;
		
		
		var icon = new Bitmap(Assets.getBitmapData(img));
		addChild(icon);	
		txt.x = icon.width;
	}
	
	public function setValue(value:Int)
	{
		txt.text = "" + value;
	}
	
}