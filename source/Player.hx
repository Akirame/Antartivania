package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;

/**
 * ...
 * @author dad
 */
class Player extends FlxSprite 
{

	public function new(?X:Float=0, ?Y:Float=0) 
	{
		super(X, Y);
		makeGraphic(8, 8, 0xFFFF0000);
		acceleration.y = 1400;
	}
	
	override public function update(elapsed:Float):Void 
	{		
	
		velocity.x = 0;
		if (FlxG.keys.justPressed.Z)
			velocity.y -= 300;
		if (FlxG.keys.pressed.LEFT)
			velocity.x -= 100;
		if (FlxG.keys.pressed.RIGHT)
			velocity.x += 100;
		super.update(elapsed);
	}	
	
}