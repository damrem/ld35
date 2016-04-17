package;
import flash.display.BitmapData;
import flash.display.Sprite;
import hxlpers.Rnd;
import motion.Actuate;
import motion.easing.Linear;
import msignal.Signal.Signal1;
import openfl.Assets;
import openfl.display.Bitmap;
import openfl.geom.ColorTransform;
using hxlpers.display.BitmapDataSF;
using hxlpers.display.SpriteSF;
/**
 * @author damrem
 */

class ShipGameEvent extends AbstractGameEvent
{
	var _crew:Int;
	public var crew(get, set):Int;
	public var crewChanged:Signal1<Int>;
	
	var _gold:Int;
	var gfx:flash.display.Sprite;
	public var gold(get, set):Int;
	public var goldChanged:Signal1<Int>;
	
	
	public function new(type:String, name:String, crew:Int, gold:Int)
	{
		super(type, name);
		goldChanged = new Signal1<Int>();
		this.gold = gold;
		crewChanged = new Signal1<Int>();
		this.crew = crew;
		
		
		gfx = new Sprite();
		gfx.transform.colorTransform = new ColorTransform(1+Math.random()*0.5, 1+Math.random()*0.5, 1+Math.random()*0.5, 1, Math.random()*128, Math.random()*128, Math.random()*128);
		addChild(gfx);
		
		gfx.addChild(new Bitmap(Assets.getBitmapData("img/sea.png")));

		
		var stars = new BitmapData(512, 120, true, 0);
		stars.simpleNoise(0.005, true, true);
		(gfx.addChild(new Bitmap(stars))).alpha = Math.random()/2;
		
		
		
		for (i in 0...Std.random(8))
		{
			var cloudMask = new Sprite();
			cloudMask.rect(512, 120);
			gfx.addChild(cloudMask);
			var cloud = new Bitmap(Assets.getBitmapData("img/cloud.png"));
			cloud.mask = cloudMask;
			cloud.x = Math.random() * -512;
			cloud.alpha = Math.random() / 10;
			cloud.y = -64 + Math.random() * 256;
			gfx.addChild(cloud);
		}
		
		
		var shipMask = new Sprite();
		shipMask .rect(512, 192);
		gfx.addChild(shipMask );
		var ship = new Bitmap(Assets.getBitmapData("img/ship.png"));
		ship.mask = shipMask;
		var scale = (0.75 + Math.random() * 0.25);
		ship.scaleX = scale * (Rnd.chance()?1: -1);
		ship.scaleY = scale;
		ship.x = 128 + Math.random()*(256);
		ship.y = 48 + Std.random(12);
		gfx.addChild(ship);
		
		addTxtHolder();
		
		var crewDescription:String;
		var crewRatio = crew / Main.vampireShip.crew;
		if (crewRatio < 0.5)
		{
			crewDescription = "very weak";
		}
		else if (crewRatio < 0.75)
		{
			crewDescription = "weak";
		}
		else if (crewRatio > 1.25)
		{
			crewDescription = "strong";
		}
		else if (crewRatio > 1.5)
		{
			crewDescription = "very strong";
		}
		else
		{
			crewDescription = "average";
		}
		var crewTxt = new Txt("Crew is " + crewDescription+".", Main.ftSmall);
		crewTxt.y = txtHolder.height;
		crewTxt.width = 480;
		txtHolder.addChild(crewTxt);
		
		var lootTxt = new Txt("Loot could reach " + gold + " pieces O' eight.", Main.ftSmall);
		lootTxt.width = 480;
		lootTxt.y = txtHolder.height;
		
		txtHolder.addChild(lootTxt);
	}
	
	function get_crew():Int 
	{
		return _crew;
	}
	
	function set_crew(value:Int):Int 
	{
		_crew = value;
		crewChanged.dispatch(_crew);
		return _crew;
	}
	
	function get_gold():Int 
	{
		return _gold;
	}
	
	function set_gold(value:Int):Int 
	{
		_gold = value;
		goldChanged.dispatch(_gold);
		return _gold;
	}
	
	
	override public function resolve(vampireShape:BlackulaForm)
	{
		
		
		var bonusedCrew:Float = Main.vampireShip.crew;
		
		if (vampireShape.type == Feral)
		{
			bonusedCrew += 5;
			trace("crew bonus +5");
		}
		
		var victoryRatio = bonusedCrew / (bonusedCrew + crew);
		trace("victoryRatio", victoryRatio);
		var victory = Rnd.chance(victoryRatio);
		
		var plundering:Int = 0;
		var plunderingFactor:Float;
		var plundered:Int = 0;
		var plunderedFactor:Float;
		var recruitment:Int = 0;
		var recruitmentFactor:Float;
		var casualties:Int = 0;
		var casualtiesFactor:Float;
		var regeration:Int = 0;
		var regenFactor:Float;
		var damage:Int = 0;
		var damageFactor:Float;
		
		
		recruitmentFactor = (vampireShape.type == Vampire?5:0);
		regenFactor = (vampireShape.type == Feral?0.5:0.1);
		
		plunderedFactor = 0;
		casualtiesFactor = (1 - victoryRatio) * 2.5;
		damageFactor = (1 - victoryRatio);
		
		var txtBattleResult = new Txt("", Main.ftLarge, false);
		
		if (victory)
		{
			trace("victory");
			plunderingFactor = (vampireShape.type == Swarm?1:0.25);
			txtBattleResult.text = "You're victorious Cap'tain!";
			
		}
		else
		{
			trace("defeat");
			
			txtBattleResult.text = "Aaar, you've been defeated...";
			
			plunderingFactor = 0;
			recruitmentFactor /= 2;
			regenFactor /= 2;
			
			plunderedFactor = 1 - victoryRatio;
			casualtiesFactor *= 5;
			damageFactor *= 5;
		}
		
		var sound = Assets.getSound("sounds/explosion" + Std.random(3) + ".wav");
		sound.play();
		
		Actuate
		.tween(gfx, 0.15, { x:gfx.x - 8 + Math.random() * 16/*, y:gfx.y - 8 + Math.random() * 16*/ } )
		.repeat(3)
		.reverse()
		.ease(Linear.easeNone)
		.onComplete(function() {
			
			
			//txtResult.x = width - txtResult.width - 16;
			txtBattleResult.y = txtHolder.height;
			txtHolder.addChild(txtBattleResult);
			
			
			
			
			recruitment = Std.int(Math.random() * recruitmentFactor);
			if (recruitment > 0)
			{
				var txt = new Txt("You've converted " + recruitment + " good lad"+(recruitment>=2?"s":"")+" into "+(recruitment>=2?"":"one ")+"pirate ghul"+(recruitment>=2?"s":"")+".");
				txt.y = txtHolder.height;
				txt.width = 480;
				txtHolder.addChild(txt);
			}
			
			casualties = Std.int(Math.random() * casualtiesFactor);
			if (casualties > 0)
			{
				var txt = new Txt("Damn, you've lost " + casualties + " of yer fidel pirate ghuls.");
				txt.y = txtHolder.height;
				txt.width = 480;
				txtHolder.addChild(txt);
			}
			
			
			
			plundering = Std.int(Math.random() * gold * plunderingFactor);
			if (plundering > 0)
			{
				var txt = new Txt("Yo-ho-ho, ye've earned yerself a good loot of " + plundering+ " pieces O' eight!");
				txt.y = txtHolder.height;
				txt.width = 480;
				txtHolder.addChild(txt);
			}
			
			plundered = Std.int(Math.random() * 1000 * plunderedFactor);
			if (plundered > 0)
			{
				var txt = new Txt("Ahoy, ye've been plundered "+ plundered+" pieces O' eight, ye sailing corpse.");
				txt.y = txtHolder.height;
				txt.width = 480;
				txtHolder.addChild(txt);
			}
	
			regeration = Std.int(Math.random() * (Main.blackula.maxHealth - Main.blackula.health) * regenFactor);
			if (regeration > 0)
			{
				var txt = new Txt("Handsomely fed mate, ye've regained "+ regeration+" gallon"+(regeration>=2?"s":"")+" of yer bloody blood.");
				txt.y = txtHolder.height;
				txt.width = 480;
				txtHolder.addChild(txt);
			}
			
			damage = Std.int(Math.random() * 10 * damageFactor);
			if (damage > 0)
			{
				var txt = new Txt("Take a caulk matey, ye've lost yerself "+ damage+" gallon"+(regeration>=2?"s":"")+" of yer bloody blood.");
				txt.y = txtHolder.height;
				txt.width = 480;
				txtHolder.addChild(txt);
			}
			
			
			Main.blackula.health += (regeration - damage);
			Main.vampireShip.crew += (recruitment - casualties);
			Main.vampireShip.gold += (plundering-plundered);
			
		})
		;
		
		/*Timer.delay(function() {
			oked.dispatch();
		}, 2500);*/
		
	}
}