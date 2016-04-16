package;
import openfl.display.Sprite;
import openfl.text.TextField;

/**
 * ...
 * @author damrem
 */
class VampireShapeButton extends Sprite
{
	public var vampireShape:VampireShape;
	public function new(vampireShape) 
	{
		super();
		this.vampireShape = vampireShape;
		
		buttonMode = useHandCursor = true;
		mouseChildren = false;
		var txt = new TextField();
		txt.selectable = false;
		txt.defaultTextFormat = Main.indicatorTextFormat;
		txt.text = vampireShape.name;
		addChild(txt);
	}
	
}