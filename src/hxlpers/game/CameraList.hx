package hxlpers.game;
import openfl.Lib;

/**
 * ...
 * @author damrem
 */
class CameraList
{
	var cameras:Map<String, Camera>;
	
	public function new() 
	{
		cameras = new Map<String, Camera>();
	}
	
	public function add(key:String, camera:Camera)
	{
		cameras.set(key, camera);
	}
	
	public function get(key:String)
	{
		return cameras.get(key);
	}
	
}