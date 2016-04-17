package;
import motion.Actuate;
import openfl.Assets;
import openfl.display.Bitmap;
import openfl.display.Sprite;
import openfl.events.Event;
import openfl.events.MouseEvent;
import openfl.filters.GlowFilter;
import openfl.text.TextField;
import openfl.text.TextFieldAutoSize;

/**
 * ...
 * @author damrem
 */
class BlackulaShapeButton extends Sprite
{
	var txtName:openfl.text.TextField;
	var txtHolder:openfl.display.Sprite;
	public var blackulaShape:BlackulaShape;
	public function new(blackulaShape:BlackulaShape) 
	{
		super();
		this.blackulaShape = blackulaShape;
		
		buttonMode = useHandCursor = true;
		mouseChildren = false;
		
		var bmp = new Bitmap(Assets.getBitmapData(blackulaShape.bmp));
		addChild(bmp);
		
		txtHolder = new Sprite();
		txtHolder.x = txtHolder.y = 52;
		txtHolder.visible = false;
		txtHolder.mouseEnabled = txtHolder.mouseChildren=false;
		
		txtName = new TextField();
		txtName.selectable = false;
		txtName.defaultTextFormat = Main.ftLarge;
		txtName.text = blackulaShape.name;
		txtName.embedFonts = true;
		txtName.autoSize = TextFieldAutoSize.LEFT;
		
		
		txtHolder.addChild(txtName);
		
		txtHolder.filters = [new GlowFilter(0,1,4,4,4)];
		
		var txtBonus = new Txt(blackulaShape.bonus, Main.ftSmall);
		txtBonus.width = 144;
		txtBonus.y = txtHolder.height;
		txtHolder.addChild(txtBonus);
		
		
		addEventListener(MouseEvent.MOUSE_OVER, function(evt:MouseEvent) {
			Actuate.tween(this, 0.25, { alpha:0.75 } );
			txtHolder.visible = true;
		});
		
		addEventListener(MouseEvent.MOUSE_OUT, function(evt:MouseEvent) {
			txtHolder.visible = false;
			Actuate.tween(this, 0.25, { alpha:1 } );
		});
		
		/*addEventListener(Event.ADDED, function(evt:Event) {
			
		});*/
		
	}
	
	public function addText()
	{
		parent.addChild(txtHolder);
		txtHolder.x = x+8;
		txtHolder.y = y+8;
	}
	
}