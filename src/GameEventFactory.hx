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
			return new ShipGameEvent(shipTypes[Std.random(shipTypes.length)], createShipName(), Random.int(5, 40), Random.int(0, 2500));
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
			"Hungry",
			"Seven Seas",
			"Deep Sea",
			"Fringant",
			"Inconsequent",
			"Overwhelming",
			"Touchy",
			"So 17th",
			"Late",
			"Modern"
			
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
			"Rogers",
			"Smartphone?!?",
			"Traveller",
			"Tomatoe",
			"Pea",
			"Carrot",
			"Bunny",
			"Fox",
			"Condor",
			"Eagle",
			"Hawk",
			"Warrior",
			"Merchant",
			"Muren",
			"Snake",
			"Cook",
			"Shark",
			"Octopus",
			"Scoundrel",
			"Squirrel",
			"Explorer",
			"Hunter",
			"Hog",
			"Pig",
			"Boar",
			"Turkey",
			"Hen",
			"Rooster",
			"Chester",
			"Lucy",
			"Ellen",
			"Danny",
			"Lad",
			"Boy",
			"Poney"
		];
		
		return "The " + prefixes[Std.random(prefixes.length)] + " " + names[Std.random(names.length)];
	}
	
}