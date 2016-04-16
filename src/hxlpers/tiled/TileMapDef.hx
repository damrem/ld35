package hxlpers.tiled;
import haxe.Json;
import openfl.Assets;

/**
 * ...
 * @author damrem
 */
class TileMapDef
{
	public var width:UInt;
	public var height:UInt;
	public var layers:Array<TileMapLayerDef>;
	public var orientation:TileMapOrientation;
	public var properties:Dynamic;
	public var tileHeight:UInt;
	public var tileWidth:UInt;
	public var version:UInt;
	public var tileSets:Array<TileSetDef>;
	
	public function new(json:Dynamic, assetPath:String="") 
	{
		width = json.width;
		height = json.height;
		
		layers = [];
		tileSets = [];
		
		for (layer in cast(json.layers, Array<Dynamic>))
		{
			layers.push(new TileMapLayerDef(layer));
		}
		
		for (tileSet in cast(json.tilesets, Array<Dynamic>))
		{
			if (tileSet.source == null)
			{
				tileSets.push(new TileSetDef(tileSet));
			}
			else
			{
				
				var tileSetData = Json.parse(Assets.getText(assetPath + tileSet.source));
				tileSetData.firstgid = tileSet.firstgid;
				tileSets.push(new TileSetDef(tileSetData));
			}
		}
		
		var orientationMapping = new Map<String, TileMapOrientation>();
		orientationMapping.set("orthogonal", TileMapOrientation.Orthogonal);
		orientationMapping.set("isometric", TileMapOrientation.Isometric);
		orientationMapping.set("staggered", TileMapOrientation.Staggered);
		orientation = orientationMapping.get(json.orientation);
		
		properties = json.properties;
		tileWidth = json.tilewidth;
		tileHeight = json.tileheight;
		
		version = json.version;
	}
	
}

enum TileMapOrientation 
{
	Orthogonal;
	Isometric;
	Staggered;
}