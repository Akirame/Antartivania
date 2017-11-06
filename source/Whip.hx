package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;

/**
 * ...
 * @author G
 */
class Whip extends FlxSprite 
{
	private var damage:Int;
	public function new(?X:Float=0, ?Y:Float=0) 
	{
		super(X, Y);
		makeGraphic(16, 4, 0xFFFFFF00);	
		damage = 1;
	}
	
	override public function update(elapsed:Float):Void 
	{
		super.update(elapsed);
		FlxG.overlap(this, Global.enemyGroup, attackEnemy);
	}
	
	private function attackEnemy(a:Whip,e:Enemy):Void
	{
		e.attack(damage);
	}
}