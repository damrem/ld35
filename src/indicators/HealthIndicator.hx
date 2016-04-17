package indicators;
import openfl.Assets;
import openfl.display.Bitmap;
import openfl.display.Sprite;
import openfl.text.TextField;

/**
 * ...
 * @author damrem
 */
class HealthIndicator extends Sprite
{
	public var txt:openfl.text.TextField;

	public function new() 
	{
		super();
		txt = new TextField();
		txt.embedFonts = true;
		txt.selectable = false;
		txt.defaultTextFormat = Main.ftHuge;
		addChild(txt);
		txt.y = 8;
		txt.text = "" + Main.blackula.health;
		//txt.setTextFormat(Main.ftLarge);
		Main.blackula.healthChanged.add(function(health, isDead)
		{
			txt.text = ""+health;
		});
		
		var heart=addChild(new Bitmap(Assets.getBitmapData("img/heart.png")));
		txt.x = heart.width;
	}
	
	
	
	
	
}