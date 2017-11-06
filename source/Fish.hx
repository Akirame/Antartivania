package;

import flixel.FlxG;
import flixel.system.FlxAssets.FlxGraphicAsset;

/**
 * ...
 * @author Yope
 *
 * CURA AL PERSONAJE (CORAZON)
 *
 *
 */
class Fish extends Collectable
{
	private var cuant:Int;
	public function new(?X:Float=0, ?Y:Float=0, ?SimpleGraphic:FlxGraphicAsset)
	{
		super(X, Y, SimpleGraphic);
		makeGraphic(8, 8, 0xFF909090);
		cuant = 2;
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
		if (FlxG.overlap(this, Global.player))
		{
			Global.player.takeHealth(cuant);
			destroy();
		}
	}

}