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
	public function new(?X:Float=0, ?Y:Float=0, ?SimpleGraphic:FlxGraphicAsset) 
	{
		super(X, Y, SimpleGraphic);
		makeGraphic(8, 2, 0xFFFF00FF);
		Global.proyectiles.add(this);
	}
	
	override public function update(elapsed:Float):Void 
	{
		move();
		super.update(elapsed);
		/*if (FlxG.overlap(this, Global.player))
			trace("HIT!");*/
		checkBoundaries();
	}
	
	private function checkBoundaries():Void
	{
		if (x < 0 || x > FlxG.camera.scroll.x + FlxG.camera.width)
		{
			Global.proyectiles.remove(this, true);
			destroy();
		}
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