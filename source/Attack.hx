package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;

/**
 * ...
 * @author G
 */
class Attack extends FlxSprite 
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
		FlxG.overlap(this, Global.enemyGroup,attackEnemy)
		super.update(elapsed);
	}
	
	private function attackEnemy(a:Attack,e:Enemy):Void
	{
		e.attack(damage);
	}
}