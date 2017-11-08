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
		loadGraphic(AssetPaths.bombSheet__png, true, 32, 32);
		animation.add("active", [0, 1, 2, 3], 8, false);
		animation.add("boom", [4, 5, 6], 8, false);
		scale.set(0.5, 0.5);
		updateHitbox();
		setFacingFlip(FlxObject.LEFT, true, false);
		setFacingFlip(FlxObject.RIGHT, false, false);
		if (Global.player.facing == FlxObject.RIGHT)
		{
		facing = FlxObject.RIGHT;
		acceleration.y = 400;
		velocity.set(75, -150);
		}
		else if (Global.player.facing == FlxObject.LEFT)
		{
		facing = FlxObject.LEFT;
		acceleration.y = 400;
		velocity.set(-75, -150);
		}
		animation.play("active");
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
		scale.set(2, 2);
		updateHitbox();	
		animation.play("boom");
		if (facing == FlxObject.LEFT)
		setPosition(x - width/2, y);		
		
		acceleration.set(0, 0);
		velocity.set(0, 0);
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