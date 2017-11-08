package;

import AxeSecondary;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.math.FlxPoint;
import flixel.math.FlxVelocity;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;

/**
 * ...
 * @author dad
 */

enum Estado
{
	IDLE;
	RUN;
	JUMP;
	FALL;
	ATTACK;
	SECONDARY;
	CLIMBING;
}

enum Upgrades
{
	NONE;
	AXE;
	KNIFE;
	SHIELD;
}
class Player extends FlxSprite
{

	private var state:Estado = Estado.FALL;
	private var direction(get, null):Int;
	private var whip:Whip;
	private var timerAttack:Float = 0;
	private var attacking:Bool;
	private var canBeAttacked:Bool;
	private var timeAttacked:Float = 0;
	private var energy:Int;
	private var secondary:Upgrades = Upgrades.NONE;
	private var axe:AxeSecondary;
	private var knife:KnifeSecondary;
	private var shield:ShieldSecondary;
	private var attacking2nd:Bool;

	public function new(?X:Float=0, ?Y:Float=0)
	{
		super(X, Y);
		loadGraphic(AssetPaths.playerSheet__png, true, 40, 19);
		scale.x = 0.5;
		updateHitbox();
		scale.y = 1.5;
		updateHitbox();
		scale.x = 1.5;
		
		
		acceleration.y = 1400;
		setFacingFlip(FlxObject.LEFT, true, false);
		setFacingFlip(FlxObject.RIGHT, false, false);
		animation.add("idle", [0,1], 8, true);
		animation.add("run", [2, 3], 8, true);
		animation.add("attack", [3,4, 5], 8, false);
		animation.add("jump", [6, 7, 8], 8, true);
		animation.add("second", [5], 8, true);
		whip = new Whip(x, y);		
		FlxG.state.add(whip);
		direction = 1;
		whip.kill();
		attacking = false;
		canBeAttacked = true;
		attacking2nd = false;
		health = 8;
		energy = 0;
		direction = 1;
	}

	override public function update(elapsed:Float):Void
	{
	
		stateMachine();
		super.update(elapsed);
		acceleration.x = 0;
		attackedManagment();		
		whip.changePosition();
	}
	
	private function traceState():Void
	{
		trace("Estado:" + state);		
	}
	
	private function attackedManagment():Void 
	{
		if (canBeAttacked == false)
		{
			timeAttacked += FlxG.elapsed;
		}
		if (timeAttacked >= 2)
		{
			canBeAttacked = true;
			timeAttacked = 0;
		}
	}

	private function stateMachine():Void
	{
		switch (state)
		{
			case Estado.IDLE:
				if(!attacking)
				animation.play("idle");
				hMove();
				jump();
				attack();
				if (attacking)
					state = Estado.ATTACK;
				if (attacking2nd)
					state = Estado.SECONDARY;
				if (velocity.y < 0)
					state = Estado.JUMP;
				else if (velocity.x != 0)
					state = Estado.RUN;
				else if (acceleration.y == 0)
					state = Estado.CLIMBING;

			case Estado.RUN:				
				hMove();
				jump();
				attack();
				if (attacking)
					state = Estado.ATTACK;
				if (attacking2nd)
					state = Estado.SECONDARY;
				if (velocity.y > 0)
				{
					state = Estado.FALL;
				}
				else if (velocity.y < 0)
					state = Estado.JUMP;
				else if (velocity.x == 0)
					state = Estado.IDLE;
				else if (acceleration.y == 0)
					state = Estado.CLIMBING;

			case Estado.JUMP:				
				attack();
				if (velocity.y == 0)
				{
					if (velocity.x == 0)
					{
						state = Estado.IDLE;
					}
					else
						state = Estado.RUN;
				}
			case Estado.FALL:
				animation.play("jump");
				velocity.x = 0;
				if (isTouching(FlxObject.FLOOR))
					state = Estado.IDLE;

			case Estado.ATTACK:						
				timerAttack += FlxG.elapsed;
				if(isTouching(FlxObject.FLOOR))
					velocity.x = 0;
				if (timerAttack > 0.5)
				{
					timerAttack = 0;
					whip.kill();
					attacking = false;				
					state = Estado.IDLE;
				}
			
			case Estado.SECONDARY:
				animation.play("second");
				timerAttack += FlxG.elapsed;
				if(isTouching(FlxObject.FLOOR))
					velocity.x = 0;
				if (timerAttack > 0.3)				
				{
					timerAttack = 0;					
					attacking2nd = false;				
					state = Estado.IDLE;
				}
			case Estado.CLIMBING:
				if (isTouching(FlxObject.FLOOR))
					state = Estado.IDLE;
		}
	}

	private function jump():Void
	{

		if (FlxG.keys.pressed.Z)
		{
			animation.play("jump");
			velocity.y -= 300;
		}
	}

	private function attack():Void
	{	
		if (FlxG.keys.pressed.UP && FlxG.keys.justPressed.X && energy>0)
		{
			attacking2nd = true;
			switch (secondary) 
			{
				case Upgrades.NONE:
					
				case Upgrades.AXE:
					axe = new AxeSecondary(x, y);
					FlxG.state.add(axe);
					energy--;
				case Upgrades.KNIFE:
					knife = new KnifeSecondary(x, y+ width/2);
					FlxG.state.add(knife);
					energy--;
				case Upgrades.SHIELD:
					shield = new ShieldSecondary(x, y);
					FlxG.state.add(shield);
					if (energy >= 2)
					energy -= 2;
					else
					energy--;
			}
		}
		else if (FlxG.keys.justPressed.X)
		{
			animation.play("attack");
			whip.revive();
			attacking = true;
		}
	}

	private function hMove():Void
	{
		if (FlxG.keys.pressed.LEFT)
		{			
			velocity.x = -100 * FlxG.elapsed * FlxG.updateFramerate;
			direction = -1;
		}
		else if (FlxG.keys.pressed.RIGHT)
		{			
			velocity.x = 100 * FlxG.elapsed * FlxG.updateFramerate;
			direction = 1;
		}
		else
			velocity.x = 0;
		if (isTouching(FlxObject.FLOOR) && velocity.y == 0)
		{
			if (velocity.x != 0)
			{				
				facing = (velocity.x > 0) ? FlxObject.RIGHT : FlxObject.LEFT;
				if (!attacking)
				animation.play("run");
			}
		}
	}
	
	public function takeHealth(cuant:Int):Void
	{
		if (health < 10)
			health += cuant;
		else
			health = 10;
	}
	
	public function addEnergy():Void
	{
		energy += 5;
	}
	
	public function getEnergy():Int
	{
		return energy;
	}
	
	public function takeDamage(damage:Int):Void
	{
		if (canBeAttacked && health > 0)
		{
			canBeAttacked = false;
			health -= damage;
			velocity.set(50 *direction, -50);
		}
	}
	
	public function get_direction():Int 
	{
		return direction;
	}
	
	public function setSecondary(_secondary:Upgrades):Void
	{
		secondary = _secondary;
	}
	
}