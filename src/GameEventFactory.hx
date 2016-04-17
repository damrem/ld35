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
			return new ShipGameEvent(shipTypes[Std.random(shipTypes.length)], createShipName(), Random.int(5, Math.ceil(Main.gameEventHistory.length/5)*5), Random.int(0, 2500));
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
			"Modern",
			"Angry",
			"Sea",
			"Grumpy",
			"Winged",
			"Tentacular",
			"Ugly",
			"Giant",
			"Small",
			"Fast",
			"Heavy",
			"Cute",
			"Mean",
			"Kind",
			"Smelly",
			"Bad",
			"Invisible",
			"Corrosive",
			"Vicious",
			"Nervous",
			"Cocky",
			"Valiant", 
			"Happy",  
			"Brave", 
			"Epic", 
			"Floppy", 
			"Jealous",
			"One Eye",
			"Silent",
			"White",
			"Black",
			"Green",
			"Pinky",
			"Punky",
			"Ambiguous",
			"Shady",
			"Sloppy",
			"Thug",
			"Greedy",
			"Special",
			"Not-so-fast",
			"Villain",
			"Heroic",
			"Skunky",
			"Spooky",
			"Snoring"
			
		];
		var names = [
			"Madame",
			"Duchess",
			"Empress",
			"Fairy",
			"Queen",
			"Princess",
			"Betty",
			"Feather",
			"Yggdrasil",
			"Flower",
			"Lotus",
			"Orange",
			"Mermaid",
			"Harpy",
			"Siren",
			"Ghost",
			"Dog",
			"European",
			"French",
			"Spanish",
			"Conquistador",
			"Bull",
			"Killer",
			"Thief",
			"Sir",
			"Lady",
			"Father",
			"Master",
			"Liar",
			"Glutton",
			"Giant",
			"Dwarf",
			"Tentacle",
			"Wing",
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
			"Poney",
			"Butcher"
		];
		
		return "The " + prefixes[Std.random(prefixes.length)] + " " + names[Std.random(names.length)];
	}
	
}