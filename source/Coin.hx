package;

import flixel.FlxG;
import flixel.system.FlxAssets.FlxGraphicAsset;

/**
 * ...
 * @author ...
 */
class Coin extends Collectable 
{
	private var score:Int;
	public function new(?X:Float=0, ?Y:Float=0, ?SimpleGraphic:FlxGraphicAsset) 
	{
		super(X, Y, SimpleGraphic);
		score = 1000;
	}
	
	override public function update(elapsed:Float):Void 
	{
		super.update(elapsed);
		if (FlxG.overlap(this, Global.player))
		{
			Global.score+= score;
			destroy();
		}
	}
	
}