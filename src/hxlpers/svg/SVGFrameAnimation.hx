package hxlpers.svg;
import format.SVG;
import msignal.Signal.Signal0;
import openfl.display.Sprite;
import openfl.Lib;

/**
 * ...
 * @author damrem
 */
class SVGFrameAnimation extends Sprite
{
	var frames:Array<SVG>;
	var isPlaying:Bool;
	var currentFrameId:Int=0;
	
	public var playMode:AnimationPlayMode = Yoyo;
	var yoyoDirection:YoyoDirection = Forward;
	
	var _iterationEnded:Signal0;
	var nbLoops:UInt;
	var currentLoop:UInt;
	var frameFrequency:Float = 5;
	var framePeriodMs:Float;
	var time:Float;
	public var iterationEnded(get, null):Signal0;
	
	/**
	 * 
	 * @param	initialFramId
	 * 
	 */
	public function new() 
	{
		super();
		
		playMode = Yoyo;
		
		frames = new Array<SVG>();
		
		framePeriodMs = 1000 / frameFrequency;
		
		_iterationEnded = new Signal0();
		
		time = Lib.getTimer();
	}
	
	public function addFrame(frame:SVG):SVG
	{
		frames.push(frame);
		return frame;
	}
	
	public function addFrames(frames:Array<SVG>)
	{
		this.frames.concat(frames);
		
	}
	
	/**
	 * @param	nbLoops	0 for infinite.
	 */
	public function play(nbLoops:UInt = 0)
	{
		this.nbLoops = nbLoops;
		isPlaying = true;
	}
	
	public function pause()
	{
		isPlaying = false;
	}
	
	public function update()
	{
		if (Lib.getTimer() - time > framePeriodMs)
		{
			time = Lib.getTimer();
		
			graphics.clear();
			
			switch(playMode)
			{
				case Normal:
					updateNormal();

				case Yoyo:
					updateYoyo();

			}
			
			frames[currentFrameId].render(graphics);
		
		}
	}
	
	function updateNormal() 
	{
		currentFrameId++;
		if (currentFrameId >= frames.length)
		{
			currentFrameId = 0;
			_iterationEnded.dispatch();
		}
	}
	
	function updateYoyo() 
	{
		switch(yoyoDirection)
		{
			case Forward:
				currentFrameId++;
				if (currentFrameId >= frames.length)
				{
					currentFrameId = frames.length - 2;
					yoyoDirection = Backward;
					_iterationEnded.dispatch();
				}
				
			case Backward:
				currentFrameId--;
				if (currentFrameId < 0)
				{
					currentFrameId = 1;
					yoyoDirection = Forward;
					_iterationEnded.dispatch();
				}
		}
	}
	
	function get_iterationEnded():Signal0 
	{
		return iterationEnded;
	}
	
}

enum AnimationPlayMode {
	Normal;
	Yoyo;
}

enum YoyoDirection {
	Forward;
	Backward;
}