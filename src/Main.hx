package;

import hxlpers.Rnd;
import msignal.Signal;
import openfl.Assets;
import openfl.display.Sprite;
import openfl.events.MouseEvent;
import openfl.Lib;
import openfl.text.Font;
import openfl.text.TextField;
import openfl.text.TextFormat;
import src.GameEvent;
//@:font("assets/fonts/PxPlus_AmstradPC1512.ttf") class DefaultFont extends Font { }
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
	public static var blackula:Blackula;
	
	public static var ftLarge:TextFormat;
	public static var ftSmall:TextFormat;

	public static var vampireShip:Ship;
	
	public static var eventDefs:Array<GameEvent>;
	
	public static var vampireShape:BlackulaShape;
	public static var beastShape:BlackulaShape;
	public static var batShape:BlackulaShape;
	
	public function new() 
	{
		super();
		
		//Font.registerFont (DefaultFont);
		
		blackula = new Blackula();
		blackula.healthChanged.add(function(health, isDead)
		{
			if (isDead)
			{
				gameOver();
			}
		});
		
		gameEventFactory = new GameEventFactory();
		ftLarge = new TextFormat(Assets.getFont("fonts/PxPlus_AmstradPC1512.ttf").fontName, 16, 0xffffff);
		ftSmall =new TextFormat(Assets.getFont("fonts/PxPlus_AmstradPC1512.ttf").fontName, 8, 0xffffff);

		gameEventHistory = [];
		
		vampireShape = {
			name: "Vampire Shape\n(Recruitment bonus)",
			bmp:"img/human.png",
			losingMen:0.5,
			gainingMen:0.5,
			losingMoney:0.5,
			gainingMoney:0.75,
			losingHealth:0.5,
			gainingHealth:0.1
		};
		
		beastShape = {
			name: "Feral Shape\n(Combat bonus)",
			bmp:"img/shark.png",
			losingMen:0.25,
			gainingMen:0.25,
			losingMoney:0.25,
			gainingMoney:0.5,
			losingHealth:0.25,
			gainingHealth:0.25
		};
		
		batShape = {
			name: "Swarm Shape\n(Plunder bonus)",
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
		
		
		nextEvent();
		
		
		var shapeButtonsContainer = new Sprite();
		shapeButtonsContainer.y = 232;
		addChild(shapeButtonsContainer);
		
		
		vampireButton = new BlackulaShapeButton(vampireShape);
		vampireButton.x = 0;
		shapeButtonsContainer.addChild(vampireButton);
		
		beastButton = new BlackulaShapeButton(beastShape);
		beastButton.x = 176;
		shapeButtonsContainer.addChild(beastButton);
		
		swarmButton = new BlackulaShapeButton(batShape);
		swarmButton.x = 176*2;
		shapeButtonsContainer.addChild(swarmButton);
		
		vampireButton.addText();
		beastButton.addText();
		swarmButton.addText();
		
		shapeButtonsContainer.x = (Lib.current.stage.stageWidth - shapeButtonsContainer.width) / 2;
		
		
		vampireShip = new Ship("", "", 10, 1000, 30);
		
		var indicatorsContainer = new Sprite();
		addChild(indicatorsContainer);
		indicatorsContainer.y = 404;
		
		
		var crewIndicator = new CrewIndicator();
		indicatorsContainer .addChild(crewIndicator);
		crewIndicator.x = 20;
		
		var healthIndicator = new HealthIndicator();
		indicatorsContainer .addChild(healthIndicator);
		healthIndicator.x = (Lib.current.stage.stageWidth - healthIndicator.width) / 2;
		
		var moneyIndicator = new MoneyIndicator();
		indicatorsContainer .addChild(moneyIndicator);
		moneyIndicator.x = Lib.current.stage.stageWidth - crewIndicator.width - 20;
		
		resume();
	}
	
	function resume()
	{
		vampireButton.addEventListener(MouseEvent.CLICK, resolveCurrentEvent);
		beastButton.addEventListener(MouseEvent.CLICK, resolveCurrentEvent);
		swarmButton.addEventListener(MouseEvent.CLICK, resolveCurrentEvent);
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
		currentEvent.x = 20;
		currentEvent.y = 20;
		gameEventHistory.push(currentEvent);
		addChild(currentEvent);
		
		
	}
	
	function resolveCurrentEvent(evt:MouseEvent=null)
	{
		trace("resolveCurrent");
		var selectedShape:BlackulaShape = cast(evt.currentTarget, BlackulaShapeButton).blackulaShape;
		
		currentEvent.resolve(selectedShape);
		
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
