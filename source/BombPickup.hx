package;

import flixel.system.FlxAssets.FlxGraphicAsset;

/**
 * ...
 * @author G
 */
class BombPickup extends Collectable 
{

	public function new(?X:Float=0, ?Y:Float=0, ?SimpleGraphic:FlxGraphicAsset) 
	{
		super(X, Y, SimpleGraphic);
		loadGraphic(AssetPaths.bombSheet__png, true, 32, 32);
		animation.add("active", [0], 8, true);
		scale.set(0.5, 0.5);
		updateHitbox();
		animation.play("active");
	}
	
	override public function pickup(c:Collectable, p:Player):Void 
	{
		super.pickup(c, p);
		Global.player.setSecondary(Player.Upgrades.SHIELD);
		destroy();
	}
	
}