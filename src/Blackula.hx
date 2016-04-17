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
	public var healthChanged:Signal1<Int>;
	var maxHealth:Int = 100;

	public function new() 
	{
		healthChanged = new Signal1<Int>();
	}
	
	function get_health():Int 
	{
		return _health;
	}
	
	function set_health(value:Int):Int 
	{
		_health = Mathematics.clamp(value, 0, maxHealth);
		healthChanged.dispatch(_health);
		return _health;
	}
	
}