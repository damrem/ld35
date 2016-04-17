package;
import motion.Actuate;
import msignal.Signal.Signal0;
import openfl.Assets;
import openfl.display.Bitmap;
import openfl.display.Sprite;
import openfl.events.Event;
import openfl.events.MouseEvent;
import openfl.Lib;
using hxlpers.display.SpriteSF;
/**
 * ...
 * @author damrem
 */
class IntroScreen extends Sprite
{
	public var restarted:Signal0;

	public function new() 
	{
		super();
		
		restarted = new Signal0();
		
		var txtContainer = new Sprite();
		txtContainer.x = txtContainer.y = 16;		
		addChild(txtContainer);
		
		
		var title = new Txt("Ahoy Cap'tain Blackula!", Main.ftHuge);
		txtContainer.addChild(title);
		title.width = 480;
		//title.background = true;
		//title.backgroundColor = 0xff0000;
		trace(title.stage);
		
		var parags = [
			new Txt("Ye've been a pirate Cap'tain for a while now, ye've sailed and plundered the 7 seas, ain't it?", Main.ftLarge),
			new Txt("From now on, ye're a vampire as well. Don't ask me how nor why, I bloody don't know Cap'tain. The first of his kind fer sure, the 1st 'Vampirate' ever! Your ghul crew will be useful in defeating mortal pirates...", Main.ftLarge),
			new Txt("Ye have to fulfill yer thirst for gold AND for blood now...", Main.ftLarge, true),
		];
		
		var fullZone = new Sprite();
		fullZone.rect(Lib.current.stage.stageWidth, Lib.current.stage.stageWidth, 0x00ff0000);
		fullZone.alpha = 0;
		addChild(fullZone);
		
		fullZone.addEventListener(MouseEvent.CLICK, function(evt:MouseEvent) {
			if (parags.length==0)
			{
				fullZone.mouseEnabled = false;
				addRestartButton();
				return;
			}
			var parag = parags.shift();
			//parag.background = true;
		//parag.backgroundColor = 0xff0000;
			parag.width = 480;
			parag.y = txtContainer.height + 16;
			txtContainer.addChild(parag);
			
			//txtContainer.addChild(parag);
		});
		
		addEventListener(Event.ADDED_TO_STAGE, function(evt:Event) {
			trace("added to stage", evt);
		});
	}
	
	function addRestartButton() 
	{
		var data = Assets.getBitmapData("img/setsail.png");
		var button = new Sprite(); 
		button.addChild(new Bitmap(data));
		button.x = 200;
		button.y = 280;
		addChild(button);
		button.useHandCursor = button.buttonMode = true;
		
		button.addEventListener(MouseEvent.CLICK, function(evt:MouseEvent) {
			restarted.dispatch();
		});
	}
	
}