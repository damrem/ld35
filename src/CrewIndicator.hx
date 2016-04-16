package;
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
		txt.selectable = false;
		txt.defaultTextFormat = Main.indicatorTextFormat;
		addChild(txt);
		txt.text = ""+Main.crew;
		Main.crewChanged.add(function()
		{
			txt.text = ""+Main.crew;
		});
	}
	
	
	
	
	
}