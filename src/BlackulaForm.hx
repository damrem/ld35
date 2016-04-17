package;

/**
 * @author damrem
 */

typedef BlackulaForm =
{
	var formName:String;
	var type:BlackulaFormType;
	var bonus:String;
	
	var bmp:String;
	
	var losingMen:Float;
	var gainingMen:Float;
	
	var losingMoney:Float;
	var gainingMoney:Float;
	
	var losingHealth:Float;
	var gainingHealth:Float;
}

enum BlackulaFormType
{
	Vampire;
	Feral;
	Swarm;
}