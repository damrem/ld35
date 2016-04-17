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

	public function new(txt:String, ft:TextFormat) 
	{
		super();
		embedFonts = true;
		autoSize = TextFieldAutoSize.LEFT;
		defaultTextFormat = ft;
		text = txt;
	}
	
}