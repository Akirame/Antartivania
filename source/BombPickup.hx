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
		makeGraphic(8, 8, 0xFFFFFFFF);
	}
	
	override public function pickup(c:Collectable, p:Player):Void 
	{
		super.pickup(c, p);
		Global.player.setSecondary(Player.Upgrades.SHIELD);
		destroy();
	}
	
}