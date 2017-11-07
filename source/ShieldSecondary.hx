package;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.math.FlxVelocity;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;

/**
 * ...
 * @author G
 */
class ShieldSecondary extends FlxSprite 
{
var damage:Int;
var conta:Float = 0;
var boomCount:Bool = false;
var attacking:Bool = false;
	public function new(?X:Float = 0, ?Y:Float = 0)
	{
		super(X, Y);
		damage = 1;
		makeGraphic(8, 8, 0xFFFFFFFF);
		if (Global.player.facing == FlxObject.RIGHT)
		{
		acceleration.y = 400;
		velocity.set(75, -150);
		}
		else if (Global.player.facing == FlxObject.LEFT)
		{
		acceleration.y = 400;
		velocity.set(-75, -150);
		}
	}	
	
	override public function update(elapsed:Float):Void 
	{
		super.update(elapsed);
		BOOM();
		OOB(); 		
		conta += FlxG.elapsed;		
	}
	
	function BOOM() 
	{
		if ( conta > 0.7 && !boomCount)
		{
		acceleration.set(0, 0);
		velocity.set(0, 0);
		scale.set(5, 5);
		updateHitbox();		
		damage = 2;
		boomCount = true;
		}
		if (boomCount)
		FlxG.overlap(this, Global.enemyGroup, attackEnemy);
	}
	
	private function attackEnemy(a:ShieldSecondary,e:Enemy):Void
	{
		
		if (!attacking)
		{
		e.attack(damage);	
		attacking = true;
		}
	}
	function OOB() 
	{
		if (conta > 1)		
			destroy();		
	}
	
}