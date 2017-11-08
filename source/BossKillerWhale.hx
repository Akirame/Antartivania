package;

import flixel.FlxG;
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
	public function new(?X:Float=0, ?Y:Float=0, ?SimpleGraphic:FlxGraphicAsset) 
	{
		super(X, Y, SimpleGraphic);
		loadGraphic(AssetPaths.killerWhale__png, true, 128, 98);
		animation.add("anim1", [0, 1, 2], 6, true);
		animation.add("anim2", [3, 4, 5], 6, false);
		damage = 5;
		health = 30;
		score = 10000;
	}
	
	override public function update(elapsed:Float):Void 
	{
		super.update(elapsed);
		timeMov += elapsed;
		if (timeMov >= 4)
		{
			goDown();
			timeMov = 0;
		}
		checkBoundaries();
	}
	
	private function checkBoundaries():Void
	{
		if (x < 0)
			x = 0;
		else if (x > FlxG.camera.scroll.x + FlxG.camera.width - width)
			x = FlxG.camera.scroll.x + FlxG.camera.width - width;
		if (y < 0)
			y = 0;
		else if (x > FlxG.camera.scroll.y + FlxG.camera.height - height)
			y = FlxG.camera.scroll.y + FlxG.camera.height - height;
	}
	
	private function shoot():Void
	{
		var shoot:KillerWhaleShoot = new KillerWhaleShoot(x, y + 10);
		FlxG.state.add(shoot);
	}
	
	private function goDown():Void
	{
		velocity.y = 100;
		//shoot();
		animation.play("anim2");
	}
	
	private function shootsLocos()
	{
		
	}
	
}