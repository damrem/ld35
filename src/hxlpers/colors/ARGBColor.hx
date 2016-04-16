package hxlpers.colors;

/**
 * ...
 * @author damrem
 */
abstract ARGBColor(UInt) from UInt to UInt
{

	public function new(v:UInt=0) this = v;
	
	public var red(get, set):UInt;
	public function get_red():UInt	return this & ColorComponent.RED_MASK;
	inline public function set_red(value:UInt):UInt	return this = (this & ColorComponent.RED_NEGATIVE) + (value << ColorComponent.RED_BITSHIFT);
	
	public var green(get, set):UInt;
	public function get_green():UInt	return this & ColorComponent.GREEN_MASK;
	inline public function set_green(value:UInt):UInt	return this = (this & ColorComponent.GREEN_NEGATIVE) + (value << ColorComponent.GREEN_BITSHIFT);
	
	public var blue(get, set):UInt;
	public function get_blue():UInt	return this & ColorComponent.BLUE_MASK;
	inline public function set_blue(value:UInt):UInt	return this = (this & ColorComponent.BLUE_NEGATIVE) + (value << ColorComponent.BLUE_BITSHIFT);
	
	public var alpha(get, set):UInt;
	public function get_alpha():UInt	return this & ColorComponent.ALPHA_MASK;
	inline public function set_alpha(value:UInt):UInt	return this = (this & ColorComponent.ALPHA_NEGATIVE) + (value << ColorComponent.ALPHA_BITSHIFT);
	
	
}