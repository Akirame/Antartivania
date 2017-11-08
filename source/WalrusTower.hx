package;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.system.FlxAssets.FlxGraphicAsset;

/**
 * ...
 * @author ...
 */
class WalrusTower extends Enemy 
{
	private var timerShoot:Float = 0;
	private var direction:Int;
	public function new(?X:Float=0, ?Y:Float=0, ?SimpleGraphic:FlxGraphicAsset) 
	{
		super(X, Y, SimpleGraphic);
		loadGraphic(AssetPaths.morsa__png, true, 16, 32);
		animation.add("shoot", [1,2,3,4,5,6,7], 6);
		animation.add("idle", [0], 6);
		setFacingFlip(FlxObject.LEFT, true, false);
		setFacingFlip(FlxObject.RIGHT, false, false);
		immovable = true;
		health = 4;
		damage = 0;
		score = 1250;
	}
	
	override public function update(elapsed:Float):Void 
	{
		super.update(elapsed);
		timerShoot += elapsed;
		animation.play("idle");
		if (timerShoot >= 4)
		{
			shootTusk();
			animation.play("shoot");
			timerShoot = 0;
		}
		facing = (Global.player.x >= x) ? FlxObject.LEFT : FlxObject.RIGHT;
		if (Global.player.x >= x)
			direction = 1;
		else
			direction = -1;
	}
	
	private function shootTusk():Void
	{
		if (alive)
		{
			var tusk:WalrusTusk = new WalrusTusk(x, y+4);
			tusk.setDirection(direction);
			FlxG.state.add(tusk);
		}
	}
	
	public function setDirection(dir:Int):Void
	{
		direction = dir;
	}
	
}