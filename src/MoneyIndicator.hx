package;
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
		txt.selectable = false;
		txt.defaultTextFormat = Main.indicatorTextFormat;
		addChild(txt);
		txt.text = ""+Main.Main.vampireShip.gold;
		Main.vampireShip.goldChanged.add(function(gold)
		{
			txt.text = ""+gold;
		});
	}
	
	
	
	
	
}