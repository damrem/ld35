package hxlpers.edge;

/**
 * ...
 * @author damrem
 */
class ComponentArraySF
{

	public static function getComponent<T>(user:Array<Dynamic>, type:Class<T>):T 
	{
		for (component in user)
		{
			if (Type.getClass(component) == type)
			{
				return component;
			}
		}
		return null;
	}
	
	public static function hasComponent(user:Array<T>, type:Class<T>):Bool
	{
		return getComponent(user, type) != null;
	}
	
	
	
}