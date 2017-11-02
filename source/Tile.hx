package;

import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;

/**
 * ...
 * @author G
 */
enum Tipo
{
	BOUNCING;
	TRANSPORTLEFT;
	TRANSPORTRIGHT;
}
class Tile extends FlxSprite 
{
	public var _tipo(get, null):Tipo;
	
	public function new(?X:Float = 0, ?Y:Float = 0, ?SimpleGraphic:FlxGraphicAsset,type:Tipo)
	{
		super(X, Y, SimpleGraphic);
		immovable = true;
		_tipo = type;
	}
	
	function get__tipo():Tipo 
	{
		return _tipo;
	}
	
}