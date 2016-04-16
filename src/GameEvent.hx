package src;

/**
 * ...
 * @author damrem
 */
typedef GameEvent =
{
	var name:String;
	
	var chance:Float;
	
	var maxLosingMen:Int;
	var maxGainingMen:Int;
	
	var maxLosingMoney:Int;
	var maxGainingMoney:Int;
	
	var maxLosingHealth:Int;
	var maxGainingHealth:Int;
	
	@:optional var isShip:Bool;
}