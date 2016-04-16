package;
import openfl.display.Sprite;
import openfl.text.TextField;
import openfl.text.TextFieldAutoSize;

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
		
		nameTxt = new TextField();
		nameTxt.autoSize = TextFieldAutoSize.LEFT;
		nameTxt.embedFonts = true;
		nameTxt.defaultTextFormat = Main.ftLarge;
		nameTxt.text = eventName;
		addChild(nameTxt);
		
		typeTxt = new TextField();
		typeTxt .embedFonts = true;
		typeTxt.autoSize = TextFieldAutoSize.LEFT;
		typeTxt.defaultTextFormat = Main.ftSmall;
		typeTxt.text = type;
		addChild(typeTxt);
		typeTxt.y = 20;
		
		
		
	}
	
	public function resolve(vampireShape:BlackulaShape)
	{
		
	}
	
}