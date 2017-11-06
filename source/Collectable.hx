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
	private var picked:Bool;
	public function new(?X:Float=0, ?Y:Float=0, ?SimpleGraphic:FlxGraphicAsset) 
	{
		super(X, Y, SimpleGraphic);
		picked = false;
		acceleration = 500;
	}
	
	override public function update(elapsed:Float):Void 
	{
		FlxG.collide(this, Global.tilemapActual);
		super.update(elapsed);
	}
	
}