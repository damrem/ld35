package hxlpers;

class Rnd
{
	static public function int(min:Int, max:Int=0):Int
	{
		if (min == max)	return min;
		
		if(min > max)
		{
			var temp:Int = min;
			min = max;
			max = temp;
		}
		
		return min + Std.random(max);
	}
	
	static public function float(min:Float=1, max:Float=0) 
	{
		if (min == max)	return min;
		
		if(min > max)
		{
			var temp:Float = min;
			min = max;
			max = temp;
		}
		
		return min + Math.random() * (max - min);
	}
	
	/*
	static public function ints(length:Int, min:Int=0, max:Int=-1):Array<Int>
	{
		var list = new Array<Int>();
		if(max < min)	max = length;
		if(length > (max - min + 1))
		{
			return list;
		}
		
		while(list.length < length)
		{
			var randomInt:Int = int(min, max);
			if(list.indexOf(randomInt) < 0)	//FIXME Array.indexOf not defined (in haxe3, but defined in haxe 3.3?)
			{
				list.push(randomInt);
			}
		}
		
		return list;
	}
	*/
	
	static public function chance(prob = 0.5):Bool
	{
		return Std.random(100) < prob * 100;
	}
	
	
	
	
}