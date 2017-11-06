package;

import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;

/**
 * ...
 * @author ...
 */
class Enemy extends FlxSprite
{
	private var damage:Int;
	private var attacked:Bool;
	private var timeAttacked:Float = 0;
	public function new(?X:Float=0, ?Y:Float=0, ?SimpleGraphic:FlxGraphicAsset) 
	{
		super(X, Y);
		attacked = false;
	}
	
	override public function update(elapsed:Float):Void 
	{
		super.update(elapsed);
		if (attacked)
			timeAttacked += elapsed;
		if (timeAttacked >= 0.5)
		{
			attacked = false;
			timeAttacked = 0;
		}
	}
	
	public function attack(dam:Int)
	{
		if (attacked == false)
		{
			if (health > 0)
			{
				attacked = true;
				health -= dam;
			}
			else
				kill();
		}
	}
	
}