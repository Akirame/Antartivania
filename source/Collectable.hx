package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;

/**
 * ...
 * @author Yope
 */
class Collectable extends FlxSprite 
{
	private var conta:Float = 0;
	private var picked:Bool;
	public function new(?X:Float=0, ?Y:Float=0, ?SimpleGraphic:FlxGraphicAsset) 
	{
		super(X, Y, SimpleGraphic);
		picked = false;
		acceleration.y = 500;
	}
	
	override public function update(elapsed:Float):Void 
	{
		FlxG.collide(this, Global.tilemapActual);
		super.update(elapsed);
		if (conta > 5)
		destroy();
		conta += FlxG.elapsed;
		FlxG.overlap(this, Global.player, pickup);
	}
	
	public function pickup(c:Collectable,p:Player):Void
	{
		c.destroy();
	}
}