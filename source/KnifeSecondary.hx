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
		loadGraphic(AssetPaths.knifeSheet__png, true, 29, 17);
		scale.set(0.5, 0.5);
		updateHitbox();
		animation.add("active", [0, 1], 8, true);
		setFacingFlip(FlxObject.LEFT, true, false);
		setFacingFlip(FlxObject.RIGHT, false, false);
		if (Global.player.facing == FlxObject.RIGHT)
		{
			facing = FlxObject.RIGHT;
		velocity.x = 200;
		}
		else if (Global.player.facing == FlxObject.LEFT)
		{
			facing = FlxObject.LEFT;
		velocity.x = -200;
		}
	}	
	
	override public function update(elapsed:Float):Void 
	{
		super.update(elapsed);
		animation.play("active");
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