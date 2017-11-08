package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;

/**
 * ...
 * @author ...
 */
class WalrusTusk extends FlxSprite 
{
	private var direction:Int;
	private var damage:Int;
	public function new(?X:Float=0, ?Y:Float=0, ?SimpleGraphic:FlxGraphicAsset) 
	{
		super(X, Y, SimpleGraphic);
		loadGraphic(AssetPaths.tusk__png, false, 8, 3);
		damage = 1;
	}
	
	override public function update(elapsed:Float):Void 
	{
		move();
		super.update(elapsed);
		if (FlxG.overlap(this, Global.player))
		{
			Global.player.takeDamage(damage);
			destroy();
		}
		checkBoundaries();
	}
	
	private function checkBoundaries():Void
	{
		if (x < 0 || x > FlxG.camera.scroll.x + FlxG.camera.width)
			destroy();
	}
	
	private function move():Void
	{
		velocity.x = 100 * direction;
	}
	
	public function setDirection(dir:Int):Void
	{
		direction = dir;
	}
}