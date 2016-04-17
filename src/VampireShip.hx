package;
import de.polygonal.core.math.Mathematics;
import flash.display.BitmapData;
import hxlpers.Rnd;
import msignal.Signal.Signal1;
import openfl.Assets;
import openfl.display.Bitmap;
import openfl.text.TextField;
using hxlpers.display.BitmapDataSF;
/**
 * @author damrem
 */

class VampireShip
{
	var maxCrew:Int;
	var _crew:Int;
	public var crew(get, set):Int;
	public var crewChanged:Signal1<Int>;
	
	var _gold:Int;
	public var gold(get, set):Int;
	public var goldChanged:Signal1<Int>;
	
	public function new(crew:Int, gold:Int, maxCrew:Int=30)
	{
		
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
	
	
	
}