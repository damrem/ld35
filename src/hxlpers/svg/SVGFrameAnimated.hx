package hxlpers.svg;

import format.SVG;
import openfl.Assets;
import openfl.display.BitmapData;
import openfl.display.Sprite;
import openfl.display.Tilesheet;

using hxlpers.IntSF;
using hxlpers.display.DisplayObjectSF;

/**
 * ...
 * @author damrem
 */
class SVGFrameAnimated extends Sprite
{
	var isPlaying:Bool = true;
	var animations:Map<String, SVGFrameAnimation>;
	var currentAnimationKey:Dynamic;
	
	public function new() 
	{
		super();
		animations = new Map<String, SVGFrameAnimation>();
	}
	
	public function addAnimation(key:Dynamic, animation:SVGFrameAnimation)
	{
		animations.set(key, animation);
	}
	
	public function playAnimation(key:Dynamic)
	{
		var previousAnimation = animations.get(currentAnimationKey);
		if (previousAnimation != null)
		{
			previousAnimation.pause();
		}
		removeChildren();
		
		currentAnimationKey = key;
		var currentAnim = animations.get(key);
		addChild(currentAnim);
		currentAnim.play();
		
	}
	
	public function update()
	{
		if (isPlaying)
		{
			animations.get(currentAnimationKey).update();
		}
	}
	
}