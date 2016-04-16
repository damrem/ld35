package;
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
		txt.selectable = false;
		txt.defaultTextFormat = Main.indicatorTextFormat;
		addChild(txt);
		txt.text = ""+Main.blackula.health;
		Main.blackula.healthChanged.add(function(health, isDead)
		{
			txt.text = ""+health;
		});
	}
	
	
	
	
	
}