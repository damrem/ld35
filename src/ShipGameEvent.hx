package;
import flash.display.BitmapData;
import haxe.Timer;
import hxlpers.Rnd;
import msignal.Signal.Signal1;
import openfl.Assets;
import openfl.display.Bitmap;
import openfl.Lib;
using hxlpers.display.BitmapDataSF;
/**
 * @author damrem
 */

class ShipGameEvent extends AbstractGameEvent
{
	var _crew:Int;
	public var crew(get, set):Int;
	public var crewChanged:Signal1<Int>;
	
	var _gold:Int;
	public var gold(get, set):Int;
	public var goldChanged:Signal1<Int>;
	
	
	public function new(type:String, name:String, crew:Int, gold:Int)
	{
		super(type, name);
		goldChanged = new Signal1<Int>();
		this.gold = gold;
		crewChanged = new Signal1<Int>();
		this.crew = crew;
		
		
		
		addChild(new Bitmap(Assets.getBitmapData("img/sea.png")));
		var stars = new BitmapData(512, 120, true, 0);
		stars.simpleNoise(0.005, true, true);
		(addChild(new Bitmap(stars))).alpha=0.33;
		
		var ship = new Bitmap(Assets.getBitmapData("img/ship.png"));
		var scale = (0.75 + Math.random() * 0.25);
		ship.scaleX = scale * (Rnd.chance()?1: -1);
		ship.scaleY = scale;
		ship.x = 128 + Math.random()*(256);
		ship.y = 48 + Std.random(12);
		addChild(ship);
		
		addTxtHolder();
		
		var crewDescription:String;
		var crewRatio = crew / Main.vampireShip.crew;
		if (crewRatio < 0.5)
		{
			crewDescription = "very weak";
		}
		else if (crewRatio < 0.75)
		{
			crewDescription = "weak";
		}
		else if (crewRatio > 1.25)
		{
			crewDescription = "strong";
		}
		else if (crewRatio > 1.5)
		{
			crewDescription = "very strong";
		}
		else
		{
			crewDescription = "average";
		}
		var crewTxt = new Txt("Crew is " + crewDescription+".", Main.ftSmall);
		crewTxt.y = txtHolder.height;
		crewTxt.width = 480;
		txtHolder.addChild(crewTxt);
		
		var lootTxt = new Txt("Loot could reach " + gold + " pieces O' eight.", Main.ftSmall);
		lootTxt.width = 480;
		lootTxt.y = txtHolder.height;
		
		txtHolder.addChild(lootTxt);
	}
	
	function get_crew():Int 
	{
		return _crew;
	}
	
	function set_crew(value:Int):Int 
	{
		_crew = value;
		crewChanged.dispatch(_crew);
		return _crew;
	}
	
	function get_gold():Int 
	{
		return _gold;
	}
	
	function set_gold(value:Int):Int 
	{
		_gold = value;
		goldChanged.dispatch(_gold);
		return _gold;
	}
	
	
	override public function resolve(vampireShape:BlackulaShape)
	{
		var bonusedCrew:Float = Main.vampireShip.crew;
		
		if (vampireShape.name == "Feral Shape")
		{
			bonusedCrew += 5;
			trace("crew bonus +5");
		}
		
		var victoryRatio = bonusedCrew / (bonusedCrew + crew);
		trace("victoryRatio", victoryRatio);
		var victory = Rnd.chance(victoryRatio);
		
		var plundering:Int = 0;
		var plunderingFactor:Float;
		var plundered:Int = 0;
		var plunderedFactor:Float;
		var recruitment:Int = 0;
		var recruitmentFactor:Float;
		var casualties:Int = 0;
		var casualtiesFactor:Float;
		var regeration:Int = 0;
		var regenFactor:Float;
		var damage:Int = 0;
		var damageFactor:Float;
		
		plunderingFactor = (vampireShape.name == "Swarm Shape"?1:0.25);
		recruitmentFactor = (vampireShape.name == "Vampire Shape"?0.25:0.1);
		regenFactor = (vampireShape.name == "Feral Shape"?1:0.25);
		
		plunderedFactor = 0;
		casualtiesFactor = 1 - victoryRatio;
		damageFactor = 1 - victoryRatio;
		
		var txtResult = new Txt("", Main.ftHuge, false);
		
		if (victory)
		{
			trace("victory");
			
			txtResult.text = "You're victorious Cap'tain!";
			
		}
		else
		{
			trace("defeat");
			
			txtResult.text = "Aaarh, you've been defeated...";
			
			plunderingFactor /= 2;
			recruitmentFactor /= 2;
			regenFactor /= 2;
			
			plunderedFactor = 1 - victoryRatio;
			casualtiesFactor = 1 - victoryRatio;
			damageFactor = 1 - victoryRatio;
		}
		
		txtResult.x = width - txtResult.width - 16;
		txtResult.y = height - txtResult.height - 16;
		addChild(txtResult);
		
		plundering = Std.int(Math.random() * gold * plunderingFactor);
		recruitment = Std.int(Math.random() * crew *  recruitmentFactor);
		regeration = Std.int(Math.random() * (100 - Main.blackula.health) * regenFactor);
		
		plundered = Std.int(Math.random() * (1 - victoryRatio) * 100 * plunderedFactor);
		casualties = Std.int(Math.random() * (1 - victoryRatio) * 1*casualtiesFactor);
		damage = Std.int(Math.random() * (1 - victoryRatio) * 10 * damageFactor);
		
		Main.blackula.health += (regeration - damage);
		Main.vampireShip.crew += (recruitment - casualties);
		Main.vampireShip.gold += (plundering-plundered);
		
		
		/*Timer.delay(function() {
			oked.dispatch();
		}, 2500);*/
		
	}
}