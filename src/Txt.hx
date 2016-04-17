package;
import openfl.text.TextField;
import openfl.text.TextFieldAutoSize;
import openfl.text.TextFormat;

/**
 * ...
 * @author damrem
 */
class Txt extends TextField
{

	public function new(txt:String, ft:TextFormat, multi:Bool=true) 
	{
		super();
		embedFonts = true;
		autoSize = TextFieldAutoSize.LEFT;
		selectable = false;
		defaultTextFormat = ft;
		mouseEnabled = false;
		wordWrap = multiline = multi;
		text = txt;
	}
	
}