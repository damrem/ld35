package;

import haxe.Timer;
import motion.Actuate;
import openfl.Assets;
import openfl.display.Sprite;
import openfl.events.MouseEvent;
import openfl.Lib;
import openfl.text.TextFormat;
import ResourceIndicator;
import src.GameEvent;
using hxlpers.display.SpriteSF;
/**
 * ...
 * @author damrem
 */
class Main extends Sprite 
{
	
	
	
	var totalEventChances:Float;
	var gameEventHistory:Array<AbstractGameEvent>;
	var vampireButton:openfl.display.Sprite;
	var beastButton:openfl.display.Sprite;
	var swarmButton:openfl.display.Sprite;
	var gameEventFactory:GameEventFactory;
	var currentEvent:AbstractGameEvent;
	var exitingGameEvent:AbstractGameEvent;
	var gameEventHolders:Sprite;
	var fullZone:Sprite;
	public static var blackula:Blackula;
	
	public static var ftLarge:TextFormat;
	public static var ftSmall:TextFormat;

	public static var vampireShip:VampireShip;
	
	public static var eventDefs:Array<GameEvent>;
	
	public static var vampireForm:BlackulaForm;
	public static var beastForm:BlackulaForm;
	public static var swarmForm:BlackulaForm;
	public static var ftHuge:TextFormat;
	
	public function new() 
	{
		super();
		
		//Font.registerFont (DefaultFont);
		
		fullZone = new Sprite();
		fullZone.rect(Lib.current.stage.stageWidth, Lib.current.stage.stageHeight, 0);
		fullZone.alpha = 0;
		fullZone.addEventListener(MouseEvent.CLICK, skipTransition);
		
		gameEventHolders = new Sprite();
		addChild(gameEventHolders);
		
		blackula = new Blackula();
		blackula.healthChanged.add(function(health)
		{
			if (health<=0)
			{
				gameOver();
			}
		});
		
		gameEventFactory = new GameEventFactory();
		ftLarge = new TextFormat(Assets.getFont("fonts/minya nouvelle bd.ttf").fontName, 19, 0xffffff);
		ftHuge = new TextFormat(Assets.getFont("fonts/minya nouvelle bd.ttf").fontName, 24, 0xffffff);
		ftSmall =new TextFormat(Assets.getFont("fonts/minya nouvelle rg.ttf").fontName, 14, 0xffffff);

		gameEventHistory = [];
		
		vampireForm = {
			formName: "Vampire Form",
			type:Vampire,
			bonus:"Increase your chance of converting enemy crew members into one of your pirate ghuls.",
			bmp:"img/human.png",
			losingMen:0.5,
			gainingMen:0.5,
			losingMoney:0.5,
			gainingMoney:0.75,
			losingHealth:0.5,
			gainingHealth:0.1
		};
		
		beastForm = {
			formName: "Feral Form",
			type:Feral,
			bonus:"You shark face will throw fear into the heart of your opponents. Their meat won't be that tender but might regenerate your life.",
			bmp:"img/shark.png",
			losingMen:0.25,
			gainingMen:0.25,
			losingMoney:0.25,
			gainingMoney:0.5,
			losingHealth:0.25,
			gainingHealth:0.25
		};
		
		swarmForm = {
			formName: "Swarm Form",
			type:Swarm,
			bonus:"Change into a swarm of rodents to plunder the assaulted ship pieces O' eight by pieces O' eight.",
			bmp:"img/rats.png",
			losingMen:0.75,
			gainingMen:0.0,
			losingMoney:0.75,
			gainingMoney:0.25,
			losingHealth:0,
			gainingHealth:0.25
		};
		
		eventDefs = [];
		
		eventDefs.push( {
			name: "Merchant Ship",
			chance:1,
			maxLosingMen:1,
			maxGainingMen:1,
			maxLosingMoney:0,
			maxGainingMoney:2500,
			maxLosingHealth:5,
			maxGainingHealth:5,
			isShip: true
		});
		
		eventDefs.push( {
			name: "Privateer Vessel",
			chance:0.5,
			maxLosingMen:3,
			maxGainingMen:3,
			maxLosingMoney:100,
			maxGainingMoney:500,
			maxLosingHealth:25,
			maxGainingHealth:5,
			isShip: true
		});
		
		eventDefs.push( {
			name: "Pirate Boat",
			chance:0.5,
			maxLosingMen:5,
			maxGainingMen:5,
			maxLosingMoney:500,
			maxGainingMoney:500,
			maxLosingHealth:15,
			maxGainingHealth:10,
			isShip: true
		});
		
		eventDefs.push( {
			name: "Storm",
			chance:0.5,
			maxLosingMen:5,
			maxGainingMen:5,
			maxLosingMoney:0,
			maxGainingMoney:0,
			maxLosingHealth:5,
			maxGainingHealth:0,
			isShip: true
		});
		
		
		totalEventChances = 0;
		for (eventDef in eventDefs)
		{
			totalEventChances += eventDef.chance;
		}
		
		// Assets:
		// openfl.Assets.getBitmapData("img/assetname.jpg");
		
		vampireShip = new VampireShip(10, 1000, 30);
		
		
		
		var formButtonsContainer = new Sprite();
		formButtonsContainer.y = 232;
		addChild(formButtonsContainer);
		
		
		vampireButton = new BlackulaFormButton(vampireForm);
		vampireButton.x = 0;
		formButtonsContainer.addChild(vampireButton);
		
		beastButton = new BlackulaFormButton(beastForm);
		beastButton.x = 176;
		formButtonsContainer.addChild(beastButton);
		
		swarmButton = new BlackulaFormButton(swarmForm);
		swarmButton.x = 176*2;
		formButtonsContainer.addChild(swarmButton);
		
		vampireButton.addText();
		beastButton.addText();
		swarmButton.addText();
		
		formButtonsContainer.x = (Lib.current.stage.stageWidth - formButtonsContainer.width) / 2;
		
		
		
		
		var indicatorsContainer = new Sprite();
		addChild(indicatorsContainer);
		indicatorsContainer.y = 404;
		
		
		var crewIndicator = new ResourceIndicator("img/crew.png", vampireShip.crew);
		vampireShip.crewChanged.add(crewIndicator.setValue);
		indicatorsContainer .addChild(crewIndicator);
		crewIndicator.x = 20;
		
		var healthIndicator = new ResourceIndicator("img/heart.png", blackula.health);
		blackula.healthChanged.add(healthIndicator.setValue);
		indicatorsContainer .addChild(healthIndicator);
		healthIndicator.x = (Lib.current.stage.stageWidth - healthIndicator.width) / 2;
		
		var moneyIndicator = new ResourceIndicator("img/gold.png", vampireShip.gold);
		vampireShip.goldChanged.add(moneyIndicator.setValue);
		indicatorsContainer .addChild(moneyIndicator);
		moneyIndicator.x = Lib.current.stage.stageWidth - crewIndicator.width - 20;
		
		addChild(fullZone);
		nextEvent();
		
	}
	
	function resume()
	{
		fullZone.mouseEnabled = false;
		//fullZone.removeEventListener(MouseEvent.CLICK, skipTransition);

		vampireButton.mouseEnabled =
		beastButton.mouseEnabled =
		swarmButton.mouseEnabled = true;
		
		vampireButton.addEventListener(MouseEvent.CLICK, resolveCurrentEvent);
		beastButton.addEventListener(MouseEvent.CLICK, resolveCurrentEvent);
		swarmButton.addEventListener(MouseEvent.CLICK, resolveCurrentEvent);
		
	}
	
	function pause()
	{
		vampireButton.removeEventListener(MouseEvent.CLICK, resolveCurrentEvent);
		beastButton.removeEventListener(MouseEvent.CLICK, resolveCurrentEvent);
		swarmButton.removeEventListener(MouseEvent.CLICK, resolveCurrentEvent);
		
		vampireButton.mouseEnabled =
		beastButton.mouseEnabled =
		swarmButton.mouseEnabled = false;
		
		fullZone.mouseEnabled = true;
		//fullZone.addEventListener(MouseEvent.CLICK, skipTransition);
	}
	
	
	function nextEvent() 
	{
		trace("nextEvent");
		
		//resume();
		exitingGameEvent=null;
		
		if (gameEventHistory.length > 0)
		{
			exitingGameEvent = gameEventHistory[gameEventHistory.length - 1];
		}
		
		currentEvent = gameEventFactory.createGameEvent();// eventDefs[Std.random(eventDefs.length)];
		currentEvent.x = Lib.current.stage.stageWidth;
		currentEvent.y = 20;
		gameEventHistory.push(currentEvent);
		gameEventHolders.addChild(currentEvent);
		
		transition();
		
	}
	
	function transition(duration:Float=1.0, skip:Bool=false)
	{
		var delay = (gameEventHistory.length > 1 && !skip) ? 60 : 0;
		if (exitingGameEvent != null)
		{
			//Actuate.stop(exitingGameEvent);
			Actuate.tween(exitingGameEvent, duration, { x: -exitingGameEvent.width } )
			.delay(delay)
			.onComplete(function() {
				if (exitingGameEvent.parent == gameEventHolders)
				{
					gameEventHolders.removeChild(exitingGameEvent);
				}
			})
			;
		}
		if (currentEvent != null)
		{
			//Actuate.stop(currentEvent);
			Actuate.tween(currentEvent, duration, { x:20 } )
			.delay(delay)
			.onComplete(resume)
			;
		}
	}
	
	function skipTransition(evt:MouseEvent = null)
	{
		//Actuate.stop(currentEvent);
		transition(0.1, true);
	}
	
	function resolveCurrentEvent(evt:MouseEvent=null)
	{
		trace("resolveCurrent");
		pause();
		var selectedForm:BlackulaForm = cast(evt.currentTarget, BlackulaFormButton).blackulaForm;
		
		currentEvent.resolve(selectedForm);
		
		//Actuate.tween(currentEvent, 1, { x: -currentEvent.width } )
		//.delay(2.5)
		//.onComplete(nextEvent)
		//;
		
		nextEvent();
		
		//currentEvent.oked.add(nextEvent);
		
		
		
	}
	
	function gameOver() 
	{
		removeChildren(0, numChildren-1);
	}
	
	
	
}
