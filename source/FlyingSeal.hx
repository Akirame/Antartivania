package;

import flixel.FlxG;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;

/**
 * ...
 * @author G
 */
class FlyingSeal extends Enemy 
{
	public function new(?X:Float = 0, ?Y:Float = 0)
	{
		super(X, Y);				
		makeGraphic(16, 16, 0xFF00FFFF);
		FlxTween.tween(this, {y:y - 70}, {type:FlxTween.PINGPONG, ease:FlxEase.smoothStepInOut});
		velocity.x -= 40;
		health = 1;
	}
	
	override public function update(elapsed:Float):Void 
	{
		super.update(elapsed);
		
	}
}