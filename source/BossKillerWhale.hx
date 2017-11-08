package;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.math.FlxPoint;
import flixel.math.FlxRandom;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;

/**
 * ...
 * @author Yope
 */
class BossKillerWhale extends Enemy 
{
	private var timeMov:Float = 0;
	private var posInicial:FlxPoint = new FlxPoint();
	private var random:FlxRandom = new FlxRandom();
	private var direction:Int;
	public function new(?X:Float=0, ?Y:Float=0, ?SimpleGraphic:FlxGraphicAsset) 
	{
		super(X, Y, SimpleGraphic);
		loadGraphic(AssetPaths.killerWhale__png, true, 128, 98);
		animation.add("anim1", [0, 1, 2], 6, true);
		animation.add("anim2", [3, 4, 5], 6, false);
		damage = 5;
		health = 30;
		score = 10000;
		setFacingFlip(FlxObject.LEFT, true, false);
		setFacingFlip(FlxObject.RIGHT, false, false);
		facing = FlxObject.LEFT;
		animation.play("anim1");
		posInicial.set(X, Y);
		trace(posInicial);
		direction = 1;
	}
	
	override public function update(elapsed:Float):Void 
	{
		
		super.update(elapsed);
		timeMov += elapsed;
		if (alive)
		{
		if (timeMov >= 4)
		{
			var num:Int = random.int(0, 2);
			switch (num) 
			{
				case 0:
					goDown();
				case 1:
					shootsLocos();
				case 2:
					goTowards();
				default:
					
			}
			
			timeMov = 0;
		}
		checkBoundaries();
		}
	}
	
	private function checkBoundaries():Void
	{
		if (x < FlxG.camera.scroll.x-width/2)
			x = FlxG.camera.scroll.x-width/2;
		else if (x > FlxG.camera.scroll.x + FlxG.camera.width - width)
			x = FlxG.camera.scroll.x + FlxG.camera.width - width;
		if (y < FlxG.camera.scroll.y)
			y = FlxG.camera.scroll.y;
		else if (y > FlxG.camera.scroll.y + FlxG.camera.height - height)
			y = FlxG.camera.scroll.y + FlxG.camera.height - height;
		if (x >= Global.player.x)
		{
			facing = FlxObject.RIGHT;
			direction = -1;
		}
		else
		{
			facing = FlxObject.LEFT;
			direction = 1;
		}
	}
	
	private function shoot():Void
	{
		var shoot:KillerWhaleShoot = new KillerWhaleShoot(x+width-30, y+10,direction);
		FlxG.state.add(shoot);
	}
	
	private function goDown():Void
	{
		y += 50;
		shoot();
		animation.play("anim2");
	}
	
	private function goTowards()
	{
		velocity.x = 100;
		shoot();
	}
	
	private function shootsLocos():Void
	{
		shoot();
		shoot();
		shoot();
		animation.play("anim2");
		y -= 50;
	}
	
}