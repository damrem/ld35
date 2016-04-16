package;
import openfl.Assets;
import openfl.display.Bitmap;
import openfl.display.Sprite;
import openfl.events.Event;
import openfl.events.MouseEvent;
import openfl.text.TextField;
import openfl.text.TextFieldAutoSize;

/**
 * ...
 * @author damrem
 */
class BlackulaShapeButton extends Sprite
{
	var txt:openfl.text.TextField;
	public var blackulaShape:BlackulaShape;
	public function new(vampireShape) 
	{
		super();
		this.blackulaShape = vampireShape;
		
		buttonMode = useHandCursor = true;
		mouseChildren = false;
		
		var bmp = new Bitmap(Assets.getBitmapData(vampireShape.bmp));
		addChild(bmp);
		
		
		txt = new TextField();
		txt.selectable = false;
		txt.defaultTextFormat = Main.ftSmall;
		txt.text = vampireShape.name;
		txt.embedFonts = true;
		txt.autoSize = TextFieldAutoSize.CENTER;
		txt.mouseEnabled = false;
		txt.visible = false;
		
		
		addEventListener(MouseEvent.MOUSE_OVER, function(evt:MouseEvent) {
			txt.visible = true;
		});
		
		addEventListener(MouseEvent.MOUSE_OUT, function(evt:MouseEvent) {
			txt.visible = false;
		});
		
		/*addEventListener(Event.ADDED, function(evt:Event) {
			
		});*/
		
	}
	
	public function addText()
	{
		parent.addChild(txt);
		txt.x = x;
		txt.y = y;
	}
	
}