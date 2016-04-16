package;
import de.polygonal.core.math.Mathematics;
import hxlpers.Rnd;
import msignal.Signal.Signal1;

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
	
	
	override public function resolve(vampireShape:VampireShape)
	{
		var bonusedCrew:Float = Main.vampireShip.crew;
		
		if (vampireShape.name == "Feral Shape")
		{
			bonusedCrew += 5;
		}
		else if (vampireShape.name == "Bat Shape")
		{
			bonusedCrew *= 1.5;
		}
		
		var victoryRatio = bonusedCrew / (bonusedCrew + crew);
		var victory = Rnd.chance(victoryRatio);
		
		if (victory)
		{
			Main.vampireShip.gold += Std.int(gold * victoryRatio);
			if (vampireShape.name == "Human Shape")
			{
				Main.vampireShip.crew += Std.int(crew * 0.25);
				Main.
			}
		}
		else
		{
			Main.vampireShip.gold = Std.int(Main.vampireShip.gold/2);
			Main.vampireShip.crew = Std.int(Main.vampireShip.crew * victoryRatio);
		}
		
		
	}
}