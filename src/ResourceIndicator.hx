package;
import de.polygonal.core.tween.ease.Ease;
import motion.Actuate;
import motion.easing.Cubic;
import motion.easing.Quad;
import msignal.Signal.AnySignal;
import msignal.Signal.Signal1;
import openfl.Assets;
import openfl.display.Bitmap;
import openfl.display.Sprite;
import openfl.geom.ColorTransform;
import openfl.text.TextField;

/**
 * ...
 * @author damrem
 */
class ResourceIndicator extends Sprite
{

	public var txt:TextField;
	var value:Int;
	var deltaTxt:Txt;
	
	public function new(img:String, ?initValue:Int) 
	{
		super();
		txt = new Txt("" + initValue, Main.ftHuge);
		value = initValue;
		addChild(txt);
		txt.y = 8;
		//txt.text = ""+Main.vampireShip.crew;
		
		deltaTxt = new Txt("", Main.ftHuge);
		addChild(deltaTxt);
		
		
		var icon = new Bitmap(Assets.getBitmapData(img));
		addChild(icon);	
		txt.x = icon.width;
		
		deltaTxt.x = icon.width;
		//deltaTxt.y = -8;
		deltaTxt.alpha = 0;
	}
	
	public function setValue(value:Int)
	{
		
		var delta = value-this.value;
		if (delta == 0)
		{
			return;
		}
		deltaTxt.transform.colorTransform = new ColorTransform(delta < 0?1:0, delta < 0?0:1, 0);
		deltaTxt.text = (delta > 0?"+":"") + delta;
		deltaTxt.y = -8;
		deltaTxt.alpha = 1;
		Actuate
		.tween(deltaTxt, 5.0, { y: -16, alpha:0 } )
		//.ease(Quad.easeOut)
		/*
		.onComplete(function() {
			Actuate.tween(deltaTxt, 2.5, { alpha:0 } );
		})*/;
		
		this.value = value;
		txt.text = "" + value;
	}
	
}