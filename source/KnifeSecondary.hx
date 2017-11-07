package;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;

/**
 * ...
 * @author G
 */
class KnifeSecondary extends FlxSprite 
{

	var damage:Int;

	public function new(?X:Float = 0, ?Y:Float = 0)
	{
		super(X, Y);
		damage = 1;
		makeGraphic(8, 8, 0xFFFFFFFF);
		if (Global.player.facing == FlxObject.RIGHT)
		{
		velocity.x = 300;
		}
		else if (Global.player.facing == FlxObject.LEFT)
		{
		velocity.x = -300;
		}
	}	
	
	override public function update(elapsed:Float):Void 
	{
		super.update(elapsed);
		OOB();
		FlxG.collide(this, Global.enemyGroup, attackEnemy);
	}
	
	private function attackEnemy(a:AxeSecondary,e:Enemy):Void
	{
		e.attack(damage);
		a.destroy(); 
	}
	function OOB() 
	{
		if (x < FlxG.camera.scroll.x || x > FlxG.camera.scroll.x + FlxG.camera.width)
		destroy();
	}
}