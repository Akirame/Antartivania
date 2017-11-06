package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;

/**
 * ...
 * @author G
 */
class Attack extends FlxSprite 
{

	public function new(?X:Float=0, ?Y:Float=0) 
	{
		super(X, Y);
		makeGraphic(16, 4, 0xFFFFFF00);		
	}
	
	override public function update(elapsed:Float):Void 
	{
		if (FlxG.collide(this, Global.enemyGroup))
			trace("MUERTO!");
		super.update(elapsed);
	}
}