package hxlpers.tiled;
import openfl.display.BitmapData;
import openfl.geom.Point;
import openfl.geom.Rectangle;

/**
 * ...
 * @author damrem
 */
class TileMapBitmapData extends BitmapData
{

	public function new(tileMapDef:TileMapDef, tileSetBitmapData:BitmapData) 
	{
		super(tileMapDef.width * tileMapDef.tileWidth, tileMapDef.height * tileMapDef.tileHeight, true, 0);
		
		var srcRect = new Rectangle(0, 0, tileMapDef.tileWidth, tileMapDef.tileHeight);
		var destPoint = new Point(0, 0);
		
		var tileSetDef = tileMapDef.tileSets[0];
		
		var w:UInt = tileSetDef.imageWidth - tileSetDef.margin * 2;
		var tileWidthPlusSpacing:UInt = tileSetDef.tileWidth + tileSetDef.spacing;
		var tileHeightPlusSpacing:UInt = tileSetDef.tileHeight + tileSetDef.spacing;
		var nbCols:UInt = Std.int((w + tileSetDef.spacing) / tileWidthPlusSpacing);
		var nbSpacing:UInt = nbCols - 1;
		trace("nbCols="+nbCols);
		trace(nbSpacing);
		
		
		
		var layer = tileMapDef.layers[0];
		
		
		
		
		//	TODO	we loop through x,y: compare perf with running through data: for (i in 0...layer.data.length)...
		var i:UInt = 0;	//	the index in data
		for (_y in 0...tileMapDef.height)
		{
			for (_x in 0...tileMapDef.width)
			{
				var j = layer.data[i] - tileSetDef.firstGId;	// the index in the sprite sheet (-1 because tiled indexes tiles from 1 instead of from 0)
				
				srcRect.x = tileSetDef.margin + (j % cast(nbCols)) * tileWidthPlusSpacing;
				srcRect.y = tileSetDef.margin + Std.int(j / nbCols) * tileHeightPlusSpacing;
				
				destPoint.x = _x * tileMapDef.tileWidth;
				destPoint.y = _y * tileMapDef.tileHeight;
				
				copyPixels(tileSetBitmapData, srcRect, destPoint);
				i++;
			}
		}
	}
	
}