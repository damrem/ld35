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
			return new Ship(shipTypes[Std.random(shipTypes.length)], "nom du bateau todo", Random.int(3, 15), Random.int(0, 2500));
		}
		else
		{
			return null;
		}
		
	}
	
}