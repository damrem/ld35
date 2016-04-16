package;
import de.polygonal.core.math.Mathematics;
import msignal.Signal.Signal1;
import msignal.Signal.Signal2;

/**
 * ...
 * @author damrem
 */
class Blackula
{
	var _health:Int = 100;
	public var health(get, set):Int;
	public var healthChanged:Signal2<Int, Bool>;
	var maxHealth:Int = 100;

	public function new() 
	{
		healthChanged = new Signal2<Int, Bool>();
	}
	
	function get_health():Int 
	{
		return _health;
	}
	
	function set_health(value:Int):Int 
	{
		_health = Mathematics.clamp(value, 0, maxHealth);
		healthChanged.dispatch(_health, _health==0);
		return _health;
	}
	
}