package;
import openfl.display.Sprite;
import openfl.text.TextField;

/**
 * ...
 * @author damrem
 */
class AbstractGameEvent extends Sprite
{
	var type:String;
	var typeTxt:TextField;

	var eventName:String;
	var nameTxt:TextField;
	
	public function new(type:String, eventName:String) 
	{
		super();	
		this.type = type;
		this.eventName = eventName;
		
		typeTxt = new TextField();
		typeTxt.defaultTextFormat = Main.indicatorTextFormat;
		typeTxt.text = type;
		addChild(typeTxt);
		typeTxt.y = 20;
		
		nameTxt = new TextField();
		nameTxt.defaultTextFormat = Main.indicatorTextFormat;
		nameTxt.text = eventName;
		addChild(nameTxt);
		
	}
	
	public function resolve(vampireShape:VampireShape)
	{
		
	}
	
}