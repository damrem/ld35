package hxlpers.effects;

import openfl.display.Bitmap;
import openfl.display.BitmapData;
import openfl.display.Sprite;
import openfl.events.Event;
import openfl.geom.Rectangle;


using hxlpers.display.BitmapDataSF;
/**
 * ...
 * @author damrem
 */
class ScreenWhiteNoiseEffect extends Sprite
{
	var pool:Array<Bitmap>;
	var current:Bitmap;
	var counter:UInt = 0;
	var currentId:UInt;
	var prevId:UInt;
	var period:UInt;
	
	public function new(w:UInt, h:UInt, population:UInt=10, density:Float=0.25, period:UInt=3) 
	{
		super();
		this.period = period;
		pool = new Array<Bitmap>();
		
	
		for (i in 0...population)
		{
			pool.push(new Bitmap(new BitmapData(w, h, true, 0xffffffff).simpleNoise(density)));
		}
		
		if (population > 0)
		{
			current = pool[0];
			addChild(current);
		}
		
		mouseEnabled = false;
		
	}
	
	public function update(evt:Event=null)
	{
		if (pool.length < 2) return;
		
		counter++;
		
		if (counter % period == period - 1)
		{
			next();
			counter = 0;
		}
	}
	
	public function next()
	{
		do
		{
			currentId = Std.random(pool.length);
		}
		while (currentId == prevId);
		prevId = currentId;
		removeChild(current);
		current = pool[currentId];
		addChild(current);
	}
	
}