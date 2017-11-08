package;

import flixel.FlxG;
import flixel.system.FlxAssets.FlxGraphicAsset;

/**
 * ...
 * @author Yope
 *
 * AÑADE ENERGIA(CORAZON EN CASTLEVANIA)
 *
 *
 */
class Fish extends Collectable
{
	
	
	public function new(?X:Float=0, ?Y:Float=0, ?SimpleGraphic:FlxGraphicAsset)
	{
		super(X, Y, SimpleGraphic);
		makeGraphic(8, 8, 0xFF909090);
	}

	override public function pickup(c:Collectable, p:Player):Void 
	{
		super.pickup(c, p);
		Global.player.addEnergy();
		trace(Global.player.getEnergy());
		destroy();
	}

}