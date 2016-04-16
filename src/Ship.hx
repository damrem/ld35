package;
import de.polygonal.core.math.Mathematics;
import flash.display.BitmapData;
import hxlpers.Rnd;
import msignal.Signal.Signal1;
import openfl.Assets;
import openfl.display.Bitmap;
using hxlpers.display.BitmapDataSF;
/**
 * @author damrem
 */

class Ship extends AbstractGameEvent
{
	var maxCrew:Int;
	var _crew:Int;
	public var crew(get, set):Int;
	public var crewChanged:Signal1<Int>;
	
	var _gold:Int;
	public var gold(get, set):Int;
	public var goldChanged:Signal1<Int>;
	
	public function new(type:String, name:String, crew:Int, gold:Int, maxCrew:Int=30)
	{
		super(type, name);
		this.maxCrew = maxCrew;
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
		ship.x = 112 + Math.random()*(256);
		ship.y = 48 + Std.random(12);
		addChild(ship);
	}
	
	function get_crew():Int 
	{
		return _crew;
	}
	
	function set_crew(value:Int):Int 
	{
		_crew = Mathematics.clamp(value, 0, maxCrew);
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
		else if (vampireShape.name == "Bat Shape")
		{
			bonusedCrew *= 1.5;
			trace("crew bonus +50%");
		}
		
		var victoryRatio = bonusedCrew / (bonusedCrew + crew);
		trace("victoryRatio", victoryRatio);
		var victory = Rnd.chance(victoryRatio);
		
		if (victory)
		{
			trace("victory");
			var gainedGold = Std.int(gold * victoryRatio);
			Main.vampireShip.gold += gainedGold;
			trace("gained " + gainedGold+" gold");
			
			if (vampireShape.name == "Human Shape")
			{
				var addedCrew = Std.int(crew * 0.25);
				Main.vampireShip.crew += addedCrew;
				trace("recruited " + addedCrew + " crew members");
			}
		}
		else
		{
			trace("defeat");
			
			var lostGold = Std.int(Main.vampireShip.gold * (1 - victoryRatio)/3);
			Main.vampireShip.gold -= lostGold;
			trace("lost " + lostGold + "gold");
			
			var deadCrew = Std.int(Main.vampireShip.crew * (1 - victoryRatio)/3);
			Main.vampireShip.crew -= deadCrew;
			trace(deadCrew + " crew member are dead");

			var damage = Std.int(victoryRatio * 10);
			Main.blackula.health -= damage;
			trace("took " + damage+" damage");

		}
		
		
	}
}