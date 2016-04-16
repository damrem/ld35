package;
import hxlpers.Rnd;

/**
 * ...
 * @author damrem
 */
class GameEventFactory
{
	var shipTypes:Array<String>;

	public function new() 
	{
		shipTypes = [
			"Spanish Gallion",
			"Privateer Ship",
			"Pirate Boat",
			"Merchant Ship"
		];
	}
	
	public function createGameEvent():AbstractGameEvent
	{
		if(Rnd.chance(1))
		{
			return new Ship(shipTypes[Std.random(shipTypes.length)], createShipName(), Random.int(3, 15), Random.int(0, 2500));
		}
		else
		{
			return null;
		}
		
	}
	
	function createShipName():String
	{
		var prefixes = [
			"Big",
			"Red",
			"Black",
			"Quick",
			"Independant",
			"Green",
			"Flying",
			"Perfect",
			"Pretty",
			"Jolly",
			"Sliding",
			"Wet",
			"Hungry"
		];
		var names = [
			"Maria",
			"Unicorn",
			"Scallion",
			"Destroyer",
			"Bertha",
			"Erica",
			"Pearl",
			"Hollander",
			"Skunk",
			"Stallion",
			"Scourge",
			"Jack",
			"Rogers"
		];
		
		return "The " + prefixes[Std.random(prefixes.length)] + " " + names[Std.random(names.length)];
	}
	
}