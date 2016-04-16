package hxlpers.tiled;

/**
 * ...
 * @author damrem
 */
class TileMapLayerDef
{
	public var name:String;
	public var width:UInt;
	public var height:UInt;
	public var x:UInt;
	public var y:UInt;
	public var opacity:Float;
	public var visible:Bool;
	public var properties:Dynamic;
	public var objects:Array<Dynamic>;
	public var type:TileMapLayerType;
	
	public var data:Array<Int>;
	
	public function new(json:Dynamic) 
	{
		name = json.name;
		width = json.width;
		height = json.height;
		x = json.x;
		y = json.y;
		opacity = json.opacity;
		visible = json.visible;
		properties = json.properties;
		objects = json.objects;
		data = json.data;
		trace(data);
		
		var typeMapping = new Map<String,TileMapLayerType>();
		typeMapping.set("tilelayer", TileMapLayerType.TileLayer);
		typeMapping.set("objectgroup", TileMapLayerType.ObjectGroup);
		typeMapping.set("imagelayer", TileMapLayerType.ImageLayer);
		type = typeMapping.get(json.type);
	}
	
}