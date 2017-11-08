package;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;

/**
 * ...
 * @author G
 */
class AxeSecondary extends FlxSprite 
{
	var damage:Int;

	public function new(?X:Float = 0, ?Y:Float = 0)
	{
		super(X, Y);
		loadGraphic(AssetPaths.axeSheet__png, true, 32, 32);
		animation.add("active", [0, 1, 2, 3], 8, true);
		scale.set(0.5, 0.5);
		updateHitbox();
		damage = 1;		
		setFacingFlip(FlxObject.LEFT, true, false);
		setFacingFlip(FlxObject.RIGHT, false, false);
		if (Global.player.facing == FlxObject.RIGHT)
		{
		facing = FlxObject.RIGHT;
		acceleration.y = 1000;
		velocity.set(125, -400);
		}
		else if (Global.player.facing == FlxObject.LEFT)
		{
		facing = FlxObject.LEFT;
		acceleration.y = 1000;
		velocity.set(-125, -400);
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
		if (y > FlxG.camera.scroll.y + FlxG.camera.height)
		destroy();
	}
	
}