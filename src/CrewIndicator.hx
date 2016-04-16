package;
import openfl.Assets;
import openfl.display.Bitmap;
import openfl.display.Sprite;
import openfl.text.TextField;
import openfl.text.TextFormat;

/**
 * ...
 * @author damrem
 */
class CrewIndicator extends Sprite
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
		txt.y = 8;
		txt.text = ""+Main.vampireShip.crew;
		Main.vampireShip.crewChanged.add(function(crew)
		{
			txt.text = ""+crew;
		});
		
		var icon = new Bitmap(Assets.getBitmapData("img/crew.png"));
		addChild(icon);	
		txt.x = icon.width;
	}
	
	
	
	
	
}