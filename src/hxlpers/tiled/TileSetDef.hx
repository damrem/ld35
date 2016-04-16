package hxlpers.tiled;

/**
 * ...
 * @author damrem
 */
class TileSetDef
{
	public var firstGId:UInt;
	public var image:String;
	public var imageWidth:UInt;
	public var imageHeight:UInt;
	public var margin:UInt;
	public var name:String;
	public var properties:Dynamic;
	public var spacing:UInt;
	public var tileHeight:UInt;
	public var tileWidth:UInt;
	public var tileProperties:Dynamic;
	
	public function new(json:Dynamic) 
	{
		firstGId = json.firstgid;
		image = json.image;
		imageWidth = json.imagewidth;
		imageHeight = json.imageheight;
		margin = json.margin;
		name = json.name;
		properties = json.properties;
		spacing = json.spacing;
		tileHeight = json.tileheight;
		tileWidth = json.tilewidth;
		tileProperties = json.tileproperties;
	}
	
}