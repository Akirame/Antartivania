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
		loadGraphic(AssetPaths.fishPickup__png, true, 32, 32);
		animation.add("active", [0, 1], 4, true);
		scale.set(0.3, 0.3);
		updateHitbox();
		animation.play("active");
	}

	override public function pickup(c:Collectable, p:Player):Void 
	{
		super.pickup(c, p);
		Global.player.addEnergy();
		trace(Global.player.getEnergy());
		destroy();
	}

}