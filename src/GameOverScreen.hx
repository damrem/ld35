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
class GameOverScreen extends Sprite
{
	public var restarted:Signal0;

	public function new(gold:Int) 
	{
		super();
		
		restarted = new Signal0();
		
		addChild(new Bitmap(Assets.getBitmapData("img/gameover.png")));
		
		var txtContainer = new Sprite();
		txtContainer.x = txtContainer.y = 16;		
		addChild(txtContainer);
		
		Assets.getSound("sounds/gameover.wav").play();
		
		var title = new Txt("Avast Cap'tain, game over like they say!", Main.ftHuge);
		txtContainer.addChild(title);
		title.width = 480;
		//title.background = true;
		//title.backgroundColor = 0xff0000;
		trace(title.stage);
		
		var parags = [
			new Txt("Ye've never been so dead, you skunky scallywag! The Cold Corpse form is the last one you'll take and it ain't give no bonus, fer sure!...", Main.ftLarge),
			new Txt("But... But wait mate... You still did good with all those " + gold + " pieces O' eight you plundered!", Main.ftLarge),
			new Txt("And we're in a damn game! Crafted with luuuv for Ludum Dare (#35) by @damrem! Could it be possible that...", Main.ftLarge),
			new Txt("Aye! There is a...", Main.ftLarge, true)
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
		var data = Assets.getBitmapData("img/restart.png");
		var button = new Sprite(); 
		button.addChild(new Bitmap(data));
		button.x = 160;
		button.y = 240;
		addChild(button);
		button.useHandCursor = button.buttonMode = true;
		
		button.addEventListener(MouseEvent.CLICK, function(evt:MouseEvent) {
			restarted.dispatch();
		});
	}
	
}