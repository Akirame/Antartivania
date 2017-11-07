package;

import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;

/**
 * ...
 * @author G
 */
enum Tipo
{
	BOUNCING;
	TRANSPORTLEFT;
	TRANSPORTRIGHT;
	VERTICAL;
	HORIZONTAL;
}
class Tile extends FlxSprite 
{
	public var _tipo(get, null):Tipo;
	
	public function new(?X:Float = 0, ?Y:Float = 0, ?SimpleGraphic:FlxGraphicAsset,type:Tipo)
	{
		super(X, Y, SimpleGraphic);
		immovable = true;
		_tipo = type;
		loadGraphic(AssetPaths.tilesSheet__png, true, 32, 32);		
		animation.add("transport", [0, 1, 2, 3], 6, true);
		animation.add("boingACTIVE", [5,6,5,6], 8, false);
		animation.add("boingIDLE", [4, 5], 4, true);
		setFacingFlip(FlxObject.LEFT, true, false);
		setFacingFlip(FlxObject.RIGHT, false, false);
		switch (_tipo) 
		{
			case Tipo.BOUNCING:
				scale.set(0.5, 0.5);
				updateHitbox();
				animation.play("boingIDLE");
			case Tipo.HORIZONTAL:
				FlxTween.tween(this, {x:x+100}, 3, {type:FlxTween.PINGPONG, ease:FlxEase.smoothStepInOut});
			case Tipo.TRANSPORTLEFT:
				facing = FlxObject.RIGHT;
				scale.set(0.5, 0.5);
				updateHitbox();
				animation.play("transport");
			case Tipo.TRANSPORTRIGHT:
				facing = FlxObject.LEFT;
				scale.set(0.5, 0.5);
				updateHitbox();
				animation.play("transport");
			case Tipo.VERTICAL:
					FlxTween.tween(this, {y:y-100}, 3, {type:FlxTween.PINGPONG, ease:FlxEase.smoothStepInOut});
		}
	}
	
	
	function get__tipo():Tipo 
	{
		return _tipo;
	}
	
}