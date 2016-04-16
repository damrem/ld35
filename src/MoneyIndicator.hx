package;
import openfl.Assets;
import openfl.display.Bitmap;
import openfl.display.Sprite;
import openfl.text.TextField;

/**
 * ...
 * @author damrem
 */
class MoneyIndicator extends Sprite
{
	public var txt:openfl.text.TextField;

	public function new() 
	{
		super();
		txt = new TextField();
		txt.embedFonts = true;
		txt.selectable = false;
		txt.defaultTextFormat = Main.ftLarge;
		addChild(txt);
		txt.text = "" + Main.Main.vampireShip.gold;
		txt.y = 8;
		Main.vampireShip.goldChanged.add(function(gold)
		{
			txt.text = ""+gold;
		});
		
		var coins = new Bitmap(Assets.getBitmapData("img/gold.png"));
		addChild(coins);
		txt.x = coins.width;
	}
	
	
	
	
	
}