package;

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
		loadGraphic(AssetPaths.tilesSheet__png, true, 16, 16);
		animation.add("transportLeft", [0, 1, 2, 3], 6, true);
		animation.add("transportRight", [3, 2, 1, 0], 6, true);
		animation.add("boingACTIVE", [4, 5, 4,5,4], 8, false);
		animation.add("boingIDLE", [4], 0, false);
		switch (_tipo) 
		{
			case Tipo.BOUNCING:
				animation.play("boingIDLE");
			case Tipo.HORIZONTAL:
				FlxTween.tween(this, {x:x+100}, 3, {type:FlxTween.PINGPONG, ease:FlxEase.smoothStepInOut});
			case Tipo.TRANSPORTLEFT:
				animation.play("transportLeft");
			case Tipo.TRANSPORTRIGHT:
				animation.play("transportRight");
			case Tipo.VERTICAL:
					FlxTween.tween(this, {y:y-100}, 3, {type:FlxTween.PINGPONG, ease:FlxEase.smoothStepInOut});
		}
	}
	
	function get__tipo():Tipo 
	{
		return _tipo;
	}
	
}