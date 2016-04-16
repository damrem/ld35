package hxlpers.shapes;
import openfl.display.LineScaleMode;
import openfl.display.CapsStyle;
import openfl.display.JointStyle;
/**
 * @author damrem
 */

typedef BorderDef =
{
	@:optional var thickness:Null<Float>;
	@:optional var color:Null<Int>;
	@:optional var alpha:Null<Float>;
	@:optional var pixelHinting:Null<Bool>;
	@:optional var scaleMode:LineScaleMode;
	@:optional var caps:CapsStyle;
	@:optional var joints:JointStyle;
	@:optional var miterLimit:Null<Float>;
}