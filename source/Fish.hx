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

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
		if (FlxG.overlap(this, Global.player))
		{
			Global.player.addEnergy();
			trace(Global.player.getEnergy());
			destroy();
		}
	}

}