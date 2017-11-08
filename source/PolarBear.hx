package;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.system.FlxAssets.FlxGraphicAsset;

/**
 * ...
 * @author Yope
 */
class PolarBear extends Enemy 
{
	private var direction:Int;
	public function new(?X:Float=0, ?Y:Float=0, ?SimpleGraphic:FlxGraphicAsset) 
	{
		super(X, Y, SimpleGraphic);
		loadGraphic(AssetPaths.oso__png, true, 64, 32);
		animation.add("walk", [0, 1, 2, 3], 6, true);
		setFacingFlip(FlxObject.LEFT, true, false);
		setFacingFlip(FlxObject.RIGHT, false, false);
		health = 2;
		damage = 2;
		acceleration.y = 1400;
		score = 1000;
	}
	
	override public function update(elapsed:Float):Void 
	{
		super.update(elapsed);
		move();
	}
	
	override function changeDirection():Void 
	{
		super.changeDirection();
		if (Global.player.x >= x)
			direction = 1;
		else
			direction = -1;
	}
	private function move():Void
	{
		velocity.x = direction * 50;
		facing = (velocity.x >= 0) ? FlxObject.RIGHT : FlxObject.LEFT;
		animation.play("walk");
	}
	
	public function setDirection(dir:Int):Void
	{
		direction = dir;
	}
}