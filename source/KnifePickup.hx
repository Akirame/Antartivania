package;

import flixel.system.FlxAssets.FlxGraphicAsset;

/**
 * ...
 * @author G
 */
class KnifePickup extends Collectable 
{

		public function new(?X:Float=0, ?Y:Float=0, ?SimpleGraphic:FlxGraphicAsset) 
	{
		super(X, Y, SimpleGraphic);
		loadGraphic(AssetPaths.knifeSheet__png, true, 29, 17);
		scale.set(0.5, 0.5);
		updateHitbox();
		animation.add("active", [1], 8, true);
		animation.play("active");
	}
	
	override public function pickup(c:Collectable, p:Player):Void 
	{
		super.pickup(c, p);
		Global.player.setSecondary(Player.Upgrades.KNIFE);
		destroy();
	}
}