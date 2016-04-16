package hxlpers.game;

/**
 * ...
 * @author damrem
 */
class LayerList
{
	var layers:Array<Layer>;
	
	public function new() 
	{
		layers = [];
	}
	
	public function addLayer(layer:Layer):LayerList
	{
		layers.push(layer);
		return this;
	}
	
	public function getLayerAt(i:UInt):Layer
	{
		return layers[i];
	}
	
	public function getLayers():Array<Layer>
	{
		return layers;
	}
	
	public function update()
	{
		for (layer in layers)
		{
			//layer.update();
		}
	}
	
}