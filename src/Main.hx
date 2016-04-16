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
	var eventHistory:Array<GameEvent>;
	var humanButton:openfl.display.Sprite;
	var beastButton:openfl.display.Sprite;
	var batButton:openfl.display.Sprite;
	
	public static var indicatorTextFormat:TextFormat;

	public static var health:Int = 100;
	public static var healthChanged:Signal0;
	
	public static var money:Int = 1000;
	public static var moneyChanged:Signal0;
	
	public static var crew:Int = 10;
	public static var crewChanged:Signal0;
	
	public static var eventDefs:Array<GameEvent>;
	
	public static var humanShape:VampireShape;
	public static var beastShape:VampireShape;
	public static var batShape:VampireShape;
	
	public function new() 
	{
		super();
		
		healthChanged = new Signal0();
		moneyChanged = new Signal0();
		crewChanged = new Signal0();
		
		eventHistory = [];
		
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
			//losingMen:0.25,
			maxLosingMen:1,
			//gainingMen:0.25,
			maxGainingMen:1,
			//losingMoney:0,
			maxLosingMoney:0,
			//gainingMoney:0.75,
			maxGainingMoney:2500,
			//losingHealth:1 / 3,
			maxLosingHealth:5,
			//gainingHealth:0.25,
			maxGainingHealth:5
		});
		
		eventDefs.push( {
			name: "Privateer Vessel",
			chance:0.5,
			//losingMen:0.75,
			maxLosingMen:3,
			//gainingMen:0.75,
			maxGainingMen:3,
			//losingMoney:0.1,
			maxLosingMoney:100,
			//gainingMoney:0.25,
			maxGainingMoney:500,
			//losingHealth:0.5,
			maxLosingHealth:25,
			//gainingHealth:0.1,
			maxGainingHealth:5
		});
		
		eventDefs.push( {
			name: "Pirate Boat",
			chance:0.5,
			//losingMen:0.75,
			maxLosingMen:5,
			//gainingMen:0.875,
			maxGainingMen:5,
			//losingMoney:0.25,
			maxLosingMoney:500,
			//gainingMoney:0.1,
			maxGainingMoney:500,
			//losingHealth:0.5,
			maxLosingHealth:15,
			//gainingHealth:0.1,
			maxGainingHealth:10
		});
		
		
		totalEventChances = 0;
		for (eventDef in eventDefs)
		{
			totalEventChances += eventDef.chance;
		}
		
		// Assets:
		// openfl.Assets.getBitmapData("img/assetname.jpg");
		
		nextEvent();
		
		indicatorTextFormat=new TextFormat(null, 12, 0xffffff);
		
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
		var event:GameEvent = eventDefs[Std.random(eventDefs.length)];
		eventHistory.push(event);
		trace(event.name);
	}
	
	function resolveCurrentEvent(evt:MouseEvent=null)
	{
		trace("resolveCurrent");
		var vampireShape:VampireShape = cast(evt.currentTarget, VampireShapeButton).vampireShape;
		
		var currentEvent = eventHistory[eventHistory.length - 1];
		
		if (Rnd.chance(vampireShape.losingMen))
		{
			crew += Random.int(-currentEvent.maxLosingMen, 0);
		}
		if (Rnd.chance(vampireShape.gainingMen))
		{
			crew += Random.int(0, currentEvent.maxGainingMen);
		}
		if (crew <= 0)
		{
			crew = 0;
			//gameOver();
		}
		else if (crew > 30)
		{
			crew = 30;
		}
		crewChanged.dispatch();
	
		
		
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
			money += Random.int( -currentEvent.maxLosingMoney, 0);
		}
		if (Rnd.chance(vampireShape.gainingMoney))
		{
			money += Random.int( 0, currentEvent.maxGainingMoney);
		}
		if (money <= 0)
		{
			money = 0;
			gameOver();
		}
		moneyChanged.dispatch();
		
		
		
		
		nextEvent();
		
	}
	
	function gameOver() 
	{
		removeChildren(0, numChildren-1);
	}

}
