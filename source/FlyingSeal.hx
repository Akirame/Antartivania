package;

import flixel.FlxG;
import flixel.FlxObject;
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
		FlxTween.tween(this, {y:y - 70}, {type:FlxTween.PINGPONG, ease:FlxEase.smoothStepInOut});
		loadGraphic(AssetPaths.gaviota__png, true,32,16);	
		velocity.x -= 40;
		animation.add("fly", [0, 1], 6, true);
		health = 1;
		damage = 1;
		score = 500;
	}
	
	override public function update(elapsed:Float):Void 
	{
		super.update(elapsed);
	}
}