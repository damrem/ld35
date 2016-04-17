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
	var txtHolder:Sprite;
	
	public function new(type:String, eventName:String) 
	{
		super();	
		this.type = type;
		this.eventName = eventName;
		
		txtHolder = new Sprite();
		
		nameTxt = new TextField();
		nameTxt.autoSize = TextFieldAutoSize.LEFT;
		nameTxt.embedFonts = true;
		nameTxt.defaultTextFormat = Main.ftHuge;
		nameTxt.text = eventName;
		txtHolder.addChild(nameTxt);
		
		typeTxt = new TextField();
		typeTxt .embedFonts = true;
		typeTxt.autoSize = TextFieldAutoSize.LEFT;
		typeTxt.defaultTextFormat = Main.ftLarge;
		typeTxt.text = type;
		txtHolder.addChild(typeTxt);
		typeTxt.y = txtHolder.height;
		
		txtHolder.x = txtHolder.y = 16;
	}
	
	
	function addTxtHolder()
	{
		addChild(txtHolder);
	}
	
	public function resolve(vampireShape:BlackulaShape)
	{
		
	}
	
}