package;

import hxlpers.Rnd;
import msignal.Signal;
import openfl.display.Sprite;
import openfl.events.MouseEvent;
import openfl.Lib;
import openfl.text.TextField;
import openfl.text.TextFormat;
import src.GameEvent;

/**
 * ...
 * @author damrem
 */
class Main extends Sprite 
{
	var totalEventChances:Float;
	var gameEventHistory:Array<AbstractGameEvent>;
	var humanButton:openfl.display.Sprite;
	var beastButton:openfl.display.Sprite;
	var batButton:openfl.display.Sprite;
	var gameEventFactory:GameEventFactory;
	var currentEvent:AbstractGameEvent;
	
	public static var indicatorTextFormat:TextFormat;

	public static var health:Int = 100;
	public static var healthChanged:Signal0;
	
	public static var vampireShip:Ship;
	
	public static var eventDefs:Array<GameEvent>;
	
	public static var humanShape:VampireShape;
	public static var beastShape:VampireShape;
	public static var batShape:VampireShape;
	
	public function new() 
	{
		super();
		
		gameEventFactory = new GameEventFactory();
		indicatorTextFormat=new TextFormat(null, 12, 0xffffff);

		healthChanged = new Signal0();
		
		gameEventHistory = [];
		
		humanShape = {
			name: "Human Shape",
			losingMen:0.5,
			gainingMen:0.5,
			losingMoney:0.5,
			gainingMoney:0.75,
			losingHealth:0.5,
			gainingHealth:0.1
		};
		
		beastShape = {
			name: "Feral Shape",
			losingMen:0.25,
			gainingMen:0.25,
			losingMoney:0.25,
			gainingMoney:0.5,
			losingHealth:0.25,
			gainingHealth:0.25
		};
		
		batShape = {
			name: "Flying Shape",
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
		
		
		nextEvent();
		
		
		humanButton = new VampireShapeButton(humanShape);
		humanButton.x = 10;
		humanButton.y = 200;
		addChild(humanButton);
		
		beastButton = new VampireShapeButton(beastShape);
		beastButton.x = 200;
		beastButton.y = 200;
		addChild(beastButton);
		
		batButton = new VampireShapeButton(batShape);
		batButton.x = 390;
		batButton.y = 200;
		addChild(batButton);
		
		
		
		vampireShip = new Ship("", "", 10, 1000, 30);
		(addChild(new HealthIndicator())).x = 10;
		(addChild(new CrewIndicator())).x=100;
		(addChild(new MoneyIndicator())).x=190;
		
		resume();
	}
	
	function resume()
	{
		humanButton.addEventListener(MouseEvent.CLICK, resolveCurrentEvent);
		beastButton.addEventListener(MouseEvent.CLICK, resolveCurrentEvent);
		batButton.addEventListener(MouseEvent.CLICK, resolveCurrentEvent);
	}
	
	
	function nextEvent() 
	{
		trace("nextEvent");
		
		if (gameEventHistory.length > 0)
		{
			currentEvent = gameEventHistory[gameEventHistory.length - 1];
			removeChild(currentEvent);
		}
		
		currentEvent = gameEventFactory.createGameEvent();// eventDefs[Std.random(eventDefs.length)];
		currentEvent.x = currentEvent.y = 100;
		gameEventHistory.push(currentEvent);
		addChild(currentEvent);
		
		
	}
	
	function resolveCurrentEvent(evt:MouseEvent=null)
	{
		trace("resolveCurrent");
		var vampireShape:VampireShape = cast(evt.currentTarget, VampireShapeButton).vampireShape;
		
		currentEvent.resolve(vampireShape);
		
		/*if (Rnd.chance(vampireShape.losingMen))
		{
			vampireShip.crew += Random.int(-currentEvent.maxLosingMen, 0);
		}
		if (Rnd.chance(vampireShape.gainingMen))
		{
			vampireShip.crew += Random.int(0, currentEvent.maxGainingMen);
		}
		
		
	
		
		
		if (Rnd.chance(vampireShape.losingHealth))
		{
			health+=Random.int(-currentEvent.maxLosingHealth, 0);			
		}
		if (Rnd.chance(vampireShape.gainingHealth))
		{
			health+=Random.int(0, currentEvent.maxGainingHealth);			
		}
		if (health <= 0)
		{
			health = 0;
			gameOver();
		}
		else if (health > 100)
		{
			health = 100;
		}
		healthChanged.dispatch();
	
		
		
		
		if (Rnd.chance(vampireShape.losingMoney))
		{
			vampireShip.gold += Random.int( -currentEvent.maxLosingMoney, 0);
		}
		if (Rnd.chance(vampireShape.gainingMoney))
		{
			vampireShip.gold += Random.int( 0, currentEvent.maxGainingMoney);
		}
		if (vampireShip.gold <= 0)
		{
			gameOver();
		}
		
		*/
		
		
		
		nextEvent();
		
	}
	
	function gameOver() 
	{
		removeChildren(0, numChildren-1);
	}
	
	
	
}
